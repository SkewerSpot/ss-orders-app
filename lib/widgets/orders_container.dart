import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/db/connected_stateless_widget.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/app_state.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/widgets/no_orders_placeholder.dart';

import 'order_card.dart';

/// A container for multiple [OrderCard]s.
///
/// The parent widget to hold a list of orders (open or closed).
class OrdersContainer extends ConnectedStatelessWidget {
  OrdersContainer({
    @required FirebaseService firebaseService,
  }) : super(firebaseService: firebaseService);

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
            ? this.firebaseService.getOpenOrders()
            : this.firebaseService.getClosedOrders(),
        builder: (context, snapshot) {
          List<Widget> listViewChildren = [];

          if (snapshot.data != null) {
            listViewChildren = snapshot.data
                .map((order) => OrderCard(
                      order: order,
                      firebaseService: this.firebaseService,
                    ))
                .toList();
          }

          if (appState.selectedTab == 'open') {
            if (listViewChildren.length > appState.openOrdersCount) {
              final player = AudioCache();
              player.play('doorbell.wav');
            }
            appState.setOpenOrdersCount(listViewChildren.length);
          }

          return listViewChildren.length > 0
              ? ListView(
                  children: listViewChildren,
                )
              : NoOrdersPlaceholder();
        },
      ),
    );
  }
}
