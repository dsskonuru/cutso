// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:cutso/core/providers/paytm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:webview_flutter/webview_flutter.dart';

const STATUS_LOADING = "PAYMENT_LOADING";
const STATUS_SUCCESSFUL = "PAYMENT_SUCCESSFUL";
const STATUS_PENDING = "PAYMENT_PENDING";
const STATUS_FAILED = "PAYMENT_FAILED";
const STATUS_CHECKSUM_FAILED = "PAYMENT_CHECKSUM_FAILED";

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late WebViewController? _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  void getData() {
    _webController!.evaluateJavascript("document.body.innerText").then((data) {
      Logger.root.shout(data);
      // final decodedJSON = jsonDecode(data);
      // final Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      // final Map<String, dynamic> responseJSON =
      //     json.decode(decodedJSON) as Map<String, dynamic>;
      // final checksumResult = responseJSON["status"];
      // final paytmResponse = responseJSON["data"];
      // if (paytmResponse["STATUS"] == "TXN_SUCCESS") {
      //   if (checksumResult == 0) {
      //     _responseStatus = STATUS_SUCCESSFUL;
      //   } else {
      //     _responseStatus = STATUS_CHECKSUM_FAILED;
      //   }
      // } else if (paytmResponse["STATUS"] == "TXN_FAILURE") {
      //   _responseStatus = STATUS_FAILED;
      // }
      setState(() {});
    });
  }

  Widget getResponseScreen() {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        return PaymentSuccessfulScreen();
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailedScreen();
    }
    return PaymentSuccessfulScreen();
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, watch, child) {
            final String? htmlScript = watch(paytmProvider).loadHTML();
            if (htmlScript != null) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        _webController = controller;
                        _webController!.loadUrl(Uri.dataFromString(
                                watch(paytmProvider).loadHTML()!,
                                mimeType: 'text/html')
                            .toString());
                      },
                      onProgress: (int progress) {
                        if (_loadingPayment) {
                          setState(() {
                            _loadingPayment = false;
                          });
                        }
                        Logger.root
                            .fine("WebView is loading (progress : $progress%)");
                      },
                      onPageFinished: (page) {
                        // if (page.contains("/process")) {}
                        // if (page.contains("/paymentReceipt")) {
                        // }
                        Logger.root.shout(page);
                        getData();
                      },
                    ),
                  ),
                  if (_loadingPayment)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    const Center(),
                  if (_responseStatus != STATUS_LOADING)
                    Center(child: getResponseScreen())
                  else
                    const Center()
                ],
              );
            } else {
              return Container(
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}

class PaymentSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Great!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Thank you making the payment!",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "OOPS!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Payment was not successful, Please try again Later!",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CheckSumFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Oh Snap!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
