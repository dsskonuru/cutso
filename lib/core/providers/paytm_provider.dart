import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import '../../features/cart/data/models/order.dart';
import '../../main.dart';
import '../error/failures.dart';
import 'firebase_provider.dart';

const String mid = "oRPwIe61300615679645";
const String mkey = "43Vy8f0T5WmXHGqD";
const String hostName = "securegw-stage.paytm.in";
const String websiteName = "WEBSTAGING";

final paytmProvider =
    ChangeNotifierProvider.autoDispose((ref) => PaytmNotifier());

class PaytmNotifier extends ChangeNotifier {
  // TODO: Setup Logger

  Future<dz.Either<ServerFailure, void>> initiatePayment(Order order) async {
    try {
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
      debugPrint(initResponse.toString());

      if (initResponse['body']['resultInfo']['resultStatus'].toString() ==
          'S') {
        final String txnToken = initResponse["body"]['txnToken'].toString();
        final response = AllInOneSdk.startTransaction(
          mid, // mid
          order.orderId, // orderId
          order.value.toString(), // amount
          txnToken, // txnToken
          "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=${order.orderId}", // callbackUrl
          true, // isStaging
          true, // restrictAppInvoke
        );
        response.then((value) {
          debugPrint(value.runtimeType.toString());
          debugPrint(value.toString());
        });
        return const dz.Right(null);
      } else {
        return dz.Left(ServerFailure('Could not initiate transaction'));
      }
    } catch (exception, stack) {
      container.read(crashlyticsProvider).recordError(exception, stack);
      debugPrint(exception.toString() + stack.toString());
      return dz.Left(ServerFailure(exception.toString()));
    }
  }
}
