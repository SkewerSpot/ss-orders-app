import 'package:flutter/material.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/widgets/icon_action_buton.dart';

/// A row of action buttons that act on the given order.
class OrderControlStrip extends StatelessWidget {
  final CustomerOrder order;

  OrderControlStrip({@required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconActionButton(
            icon: Icons.check_box,
            color: this.order.isCompleted ? Colors.green : Colors.grey,
            onPressed: () {
              this.order.isCompleted = !this.order.isCompleted;
              if (this.order.isCompleted)
                FirebaseService.closeOrder(this.order);
              else
                FirebaseService.openOrder(this.order);
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.cancel,
            color: this.order.isCancelled ? Colors.red : Colors.grey,
            onPressed: () {
              this.order.isCancelled = !this.order.isCancelled;
              if (this.order.isCancelled)
                FirebaseService.closeOrder(this.order);
              else
                FirebaseService.openOrder(this.order);
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.monetization_on,
            color: this.order.isPaidFor ? Colors.blue : Colors.grey,
            onPressed: () {
              this.order.isPaidFor = !this.order.isPaidFor;
              FirebaseService.updateOpenOrder(this.order);
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.receipt,
            color: this.order.isReceiptIssued ? Colors.blue : Colors.grey,
            onPressed: () {
              this.order.isReceiptIssued = !this.order.isReceiptIssued;
              FirebaseService.updateOpenOrder(this.order);
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.money_off,
            color: this.order.isDiscounted ? Colors.blue : Colors.grey,
            onPressed: () async {
              this._showDiscountDialog(context);
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.camera,
            color: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Future<void> _showDiscountDialog(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = this.order.discountAmount != null
        ? this.order.discountAmount.toString()
        : '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter discount amount:'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: textEditingController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                String inputValue = textEditingController.text;
                if (Util.isEmptyOrNull(inputValue)) inputValue = '0';
                this.order.discountAmount = double.parse(inputValue);
                if (this.order.discountAmount > 0)
                  this.order.isDiscounted = true;
                else
                  this.order.isDiscounted = false;
                FirebaseService.updateOpenOrder(this.order);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
