import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/db/connected_stateful_widget.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/widgets/order_control_strip.dart';
import 'package:ss_orders/widgets/order_item_card.dart';
import 'package:ss_orders/widgets/unique_code_card.dart';

/// Visual representation of a [CustomerOrder].
class OrderCard extends ConnectedStatefulWidget {
  /// The associate order model object.
  final CustomerOrder order;

  /// Whether to display action buttons to manage order.
  final bool showControlStrip;

  /// Whether to display associated unique code information.
  final bool showUniqueCodeInfo;

  OrderCard({
    @required this.order,
    this.showControlStrip = true,
    this.showUniqueCodeInfo = false,
    @required FirebaseService firebaseService,
  }) : super(firebaseService: firebaseService);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String _minsAgo;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _minsAgo = DateTime.now()
        .difference(DateTime.parse(widget.order.timestamp))
        .inMinutes
        .toString();

    this._timer = Timer.periodic(Duration(minutes: 1), (Timer t) {
      setState(() {
        _minsAgo = DateTime.now()
            .difference(DateTime.parse(widget.order.timestamp))
            .inMinutes
            .toString();
      });
    });
  }

  @override
  void dispose() {
    this._timer.cancel();
    super.dispose();
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
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
              // TIME AGO / TIME TO COMPLETE
              this.widget.order.isCompleted || this.widget.order.isCancelled
                  ? Text('Completed in ${this._completionTime().toString()}m')
                  : Text('${this._minsAgo}m ago'),
            ],
          ),

          SizedBox(height: 5.0),

          /// UNIQUE CODE
          Visibility(
            visible: this.widget.showUniqueCodeInfo &&
                !Util.isEmptyOrNull(this.widget.order.uniqueCode),
            child: UniqueCodeCard(
              code: this.widget.order.uniqueCode,
              attachedAt: DateTime.parse(this.widget.order.timestamp),
            ),
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
                            fontSize: 10.0,
                          ),
                        ),
                        Visibility(
                          visible: widget.order.discountAmount > 0,
                          child: Text(
                            ' - ₹${widget.order.discountAmount.toStringAsFixed(2)} off',
                            style: TextStyle(
                              color: kThemeColorWhite,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Text(
                          ' + ₹${widget.order.totalTax().toStringAsFixed(2)} tax',
                          style: TextStyle(
                            color: kThemeColorWhite,
                            fontSize: 10.0,
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
                          this
                              .widget
                              .firebaseService
                              .updateOpenOrder(widget.order);
                        }),
                  ))
              .toList(),

          /// ACTION BUTTONS
          Visibility(
            visible: this.widget.showControlStrip,
            child: OrderControlStrip(
              order: widget.order,
              firebaseService: this.widget.firebaseService,
            ),
          ),
        ],
      ),
    );
  }

  /// Returns time (in minutes) it took to complete the order.
  int _completionTime() {
    var receivedTime = DateTime.parse(this.widget.order.timestamp);
    var completedTime = DateTime.parse(
        Util.isEmptyOrNull(this.widget.order.completedTimestamp)
            ? this.widget.order.timestamp
            : this.widget.order.completedTimestamp);
    return completedTime.difference(receivedTime).inMinutes;
  }
}
