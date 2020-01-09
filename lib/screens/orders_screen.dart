import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/widgets/orders_tab_view.dart';
import 'package:ss_orders/widgets/screen_top_bar.dart';

/// The main and only screen in the app.
///
/// Displays a branding header and list of recent orders.
///
/// Only orders of the current date are displayed.
/// Closed orders beyond a set time limit (eg. 2 hrs) are not shown
/// because of security reasons. Since this app is meant to be
/// used by the kitchen staff, showing all orders for current day
/// may give away daily sales collection.
class OrdersScreen extends StatelessWidget {
  static final String id = 'orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColorYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: ScreenTopBar(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: OrdersTabView(),
            ),
          ],
        ),
      ),
    );
  }
}
