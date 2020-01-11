import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/app_state.dart';
import 'package:ss_orders/models/customer_order.dart';

import 'order_card.dart';

/// A container for multiple [OrderItemCard]s.
///
/// The parent widget to hold a list of orders (open or closed).
class OrdersContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

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
      child: StreamBuilder<List<CustomerOrder>>(
        stream: appState.selectedTab == 'open'
            ? FirebaseService.getOpenOrders()
            : FirebaseService.getClosedOrders(),
        builder: (context, snapshot) {
          List<Widget> listViewChildren = [];

          if (snapshot.data != null) {
            listViewChildren =
                snapshot.data.map((order) => OrderCard(order: order)).toList();
          }

          return ListView(
            children: listViewChildren,
          );
        },
      ),
    );
  }
}
