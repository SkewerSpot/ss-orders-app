import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/widgets/order_item_card.dart';

/// Visual representation of a [CustomerOrder].
class OrderCard extends StatefulWidget {
  final CustomerOrder order;

  OrderCard({@required this.order});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String _minsAgo;

  @override
  void initState() {
    super.initState();

    _minsAgo = DateTime.now()
        .difference(DateTime.parse(widget.order.timestamp))
        .inMinutes
        .toString();

    Timer.periodic(Duration(minutes: 1), (Timer t) {
      setState(() {
        _minsAgo = DateTime.now()
            .difference(DateTime.parse(widget.order.timestamp))
            .inMinutes
            .toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: kThemeColorWhite,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Row(
            children: <Widget>[
              // TOKEN NO.
              Text(
                'Token ${widget.order.token.toString()}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.0),
              // TIME AGO
              Text('${this._minsAgo}m ago'),
            ],
          ),
          SizedBox(height: 5.0),
          // META DATA
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(15.0),
              color: kThemeColorPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // CUSTOMER INFO
                    Wrap(
                      children: <Widget>[
                        Text(
                          '${widget.order.channel}',
                          style: TextStyle(
                            color: kThemeColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Visibility(
                          visible:
                              !Util.isEmptyOrNull(widget.order.customerName),
                          child: Text(
                            ' • ${widget.order.customerName}',
                            style: TextStyle(
                              color: kThemeColorWhite,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              !Util.isEmptyOrNull(widget.order.customerCarMake),
                          child: Text(
                            ' • ${widget.order.customerCarMake}',
                            style: TextStyle(
                              color: kThemeColorWhite,
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              !Util.isEmptyOrNull(widget.order.customerCarNum),
                          child: Text(
                            ' • ${widget.order.customerCarNum}',
                            style: TextStyle(
                              color: kThemeColorWhite,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !Util.isEmptyOrNull(
                              widget.order.customerComments),
                          child: Text(
                            ' • ${widget.order.customerComments}',
                            style: TextStyle(
                              color: kThemeColorWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // COST
                    Row(
                      children: <Widget>[
                        Text(
                          '₹${widget.order.totalReceivableCost().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: kThemeColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '₹${widget.order.totalCost().toStringAsFixed(2)} total',
                          style: TextStyle(
                            color: kThemeColorWhite,
                            fontSize: 12.0,
                          ),
                        ),
                        Visibility(
                          visible: widget.order.discountAmount > 0,
                          child: Text(
                            ' - ₹${widget.order.discountAmount.toStringAsFixed(2)} off',
                            style: TextStyle(
                              color: kThemeColorWhite,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Text(
                          ' + ₹${widget.order.totalTax().toStringAsFixed(2)} tax',
                          style: TextStyle(
                            color: kThemeColorWhite,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ITEMS
          ...widget.order.orderItems
              .map((item) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: OrderItemCard(
                        item: item,
                        isDoneButtonHandler: () {
                          item.isDone = !item.isDone;
                          FirebaseService.updateOpenOrder(widget.order);
                        }),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
