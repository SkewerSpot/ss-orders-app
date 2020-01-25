import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/widgets/no_orders_placeholder.dart';

import 'order_card.dart';

/// An alternative container for multiple [OrderCard]s.
///
/// Provides an alternative view of orders as compared to [OrdersContainer].
/// Hides action buttons and shows unique code for each order.
///
/// Also, unlike [OrdersContainer] that manages list of orders internally
/// this widget asks for [List] of [CustomerOrder] object in its constructor,
/// making it a more flexible and reusable alternative.
class OrdersContainerAlt extends StatelessWidget {
  final List<CustomerOrder> orders;

  OrdersContainerAlt({@required this.orders});

  @override
  Widget build(BuildContext context) {
    List<OrderCard> orderCards = this
        .orders
        .map((o) => OrderCard(
              order: o,
              showControlStrip: false,
              showUniqueCodeInfo: true,
            ))
        .toList();

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
      child: orderCards.length > 0
          ? ListView(
              children: orderCards,
            )
          : NoOrdersPlaceholder(),
    );
  }
}