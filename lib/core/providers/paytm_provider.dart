import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import '../../features/cart/data/models/order.dart';
import '../../main_common.dart';
import '../error/failures.dart';
import 'firebase_provider.dart';

const String mid = "oRPwIe61300615679645";
const String mkey = "43Vy8f0T5WmXHGqD";
const String hostName = "https://securegw-stage.paytm.in";
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
          'custId': order.uid,
          'value': order.value,
        },
      );
      final initResponse = json.decode(result.data.toString());
      container.read(loggerProvider).i(initResponse.toString());

      if (initResponse['body']['resultInfo']['resultStatus'].toString() ==
          'S') {
        final String txnToken = initResponse["body"]['txnToken'].toString();

        final Future<Map?> response = AllInOneSdk.startTransaction(
          mid, // mid
          order.orderId, // orderId
          order.value.toString(), // amount
          txnToken, // txnToken
          '$hostName/theia/paytmCallback?ORDER_ID=${order.orderId}', // callbackUrl
          true, // isStaging
          true, // restrictAppInvoke
        );
        await response.then((responseMap) {
          // TODO: navigate based on response
          container.read(loggerProvider).i(responseMap);
          if (responseMap!["STATUS"] != "TXN_SUCCESS") {
            throw Exception('Transaction Status = $responseMap!["STATUS"]}');
          }
        });
        return const dz.Right(null);
      } else {
        return dz.Left(ServerFailure('Could not start Paytm transaction'));
      }
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      container.read(loggerProvider).e(exception.toString() + stack.toString());
      return dz.Left(ServerFailure(exception.toString()));
    }
  }
}
