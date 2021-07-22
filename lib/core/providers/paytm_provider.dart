import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import '../../features/cart/data/models/order.dart';
import '../../main_common.dart';
import '../error/failures.dart';
import 'firebase_provider.dart';

const String mid = "oRPwIe61300615679645";
const String mkey = "43Vy8f0T5WmXHGqD";
const String hostName = "securegw-stage.paytm.in";
const String websiteName = "WEBSTAGING";

final paytmProvider = ChangeNotifierProvider((ref) => PaytmNotifier());

class PaytmNotifier extends ChangeNotifier {
  // TODO: Setup Logger
  Order? _order;
  Order? get currentOrder => _order;
  set currentOrder(Order? order) {
    _order = order;
    notifyListeners();
  }

  String? _txnToken;
  String? get txnToken => _txnToken;
  set txnToken(String? txnToken) {
    _txnToken = txnToken;
    notifyListeners();
  }

  Future<dz.Either<ServerFailure, void>> initiatePayment(Order order) async {
    try {
      currentOrder = order;
      final HttpsCallable callable =
          container.read(functionsProvider).httpsCallable(
                "initiateTransaction",
                options: HttpsCallableOptions(
                  timeout: const Duration(seconds: 5),
                ),
              );
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'orderId': order.orderId,
          'custId': 'test_customer',
          'value': order.value,
        },
      );
      final initResponse = json.decode(result.data.toString());
      Logger.root.fine(initResponse.toString());

      if (initResponse['body']['resultInfo']['resultStatus'].toString() ==
          'S') {
        final String txnToken = initResponse["body"]['txnToken'].toString();

        final response = AllInOneSdk.startTransaction(
          mid, // mid
          order.orderId, // orderId
          order.value.toString(), // amount
          txnToken, // txnToken
          'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=${order.orderId}', // callbackUrl
          true, // isStaging
          true, // restrictAppInvoke
        );
        response.then((value) {
          Logger.root.finer(value.runtimeType.toString());
          Logger.root.finer(value.toString());
        });
        return const dz.Right(null);
      } else {
        return dz.Left(ServerFailure('Could not start Paytm transaction'));
      }
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      Logger.root.fine(exception.toString() + stack.toString());
      return dz.Left(ServerFailure(exception.toString()));
    }
  }

  String? loadHTML() {
    if (currentOrder != null && txnToken != null && txnToken!.isNotEmpty) {
      final String html = '''
      <html>    
          <head>
            <title>Show Payment Page</title>
         </head>
         <body>
            <center>
               <h1>Please do not refresh this page...</h1>
            </center>
            <form method="post" action="https://$hostName/theia/api/v1/showPaymentPage?mid=$mid&orderId=${currentOrder!.orderId.toString()}" name="paytm">
               <table border="1">
                  <tbody>
                     <input type="hidden" name="mid" value="$mid">
                     <input type="hidden" name="orderId" value="${currentOrder!.orderId.toString()}">
                     <input type="hidden" name="txnToken" value="$txnToken">
                  </tbody>
               </table>
               <script type="text/javascript"> document.paytm.submit(); </script>
            </form>
         </body>
      </html>
      ''';
      return html;
    } else {
      Logger.root.severe("Unable to load HTML  @paytmProvider");
      return null;
    }
  }
}
