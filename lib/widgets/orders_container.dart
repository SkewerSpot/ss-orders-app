import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';

/// A container for multiple [OrderItemCard]s.
///
/// The parent widget to hold a list of orders (open or closed).
class OrdersContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        color: kThemeColorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, itemIndex) {
          return Text('Hello, friend');
        },
      ),
    );
  }
}
