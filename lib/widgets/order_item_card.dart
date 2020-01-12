import 'package:flutter/material.dart';
import 'package:ss_orders/models/order_item.dart';
import 'package:ss_orders/widgets/addon_list.dart';
import 'package:ss_orders/widgets/icon_action_buton.dart';

/// Widget to display an [OrderItem].
///
/// Displays item name, selected syrups and toppings, price,
/// and a button to mark as done.
class OrderItemCard extends StatelessWidget {
  /// The item to display in card.
  final OrderItem item;

  /// Handler for is-done button
  final Function isDoneButtonHandler;

  OrderItemCard({Key key, @required this.item, this.isDoneButtonHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // NAME
                    Text(
                      item.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    // PRICE
                    Text(
                      '₹ ${this.item.price.toString()}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    // ADDONS
                    Wrap(
                      children: <Widget>[
                        AddonList(
                          addons: this.item.syrups ?? [],
                        ),
                        AddonList(
                          addons: this.item.toppings ?? [],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconActionButton(
                icon: Icons.check_box,
                color: this.item.isDone ? Colors.green : Colors.grey,
                onPressed: this.isDoneButtonHandler,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
