import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/widgets/orders_container.dart';
import 'package:ss_orders/widgets/tab_button.dart';

/// A tabbed container to display open and closed orders in separate tabs.
///
/// Open orders are ones that are still in the pending queue.
/// Once an open order is completed or cancelled, it becomes closed.
class OrdersTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Container(
        color: kThemeColorRed,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: kOrdersViewTypes.keys
                      .map<TabButton>((key) =>
                          TabButton(id: key, text: kOrdersViewTypes[key]))
                      .toList()),
            ),
            Expanded(
              child: OrdersContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
