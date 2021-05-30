import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../widgets/address_card.dart';
import '../widgets/order_summary.dart';
import '../widgets/payment_card.dart';
import '../widgets/price_card.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () => AutoRouter.of(context).pop(),
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 24.00,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 18.00,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              OrderSummary(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Address Details',
                  style: TextStyle(
                    fontSize: 18.00,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              AddressCard(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Price Details',
                  style: TextStyle(
                    fontSize: 18.00,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              PriceCard(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Payment Details',
                  style: TextStyle(
                    fontSize: 18.00,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              PaymentCard(),
              ElevatedButton(
                onPressed: () => debugPrint('order placed'),
                child: Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
