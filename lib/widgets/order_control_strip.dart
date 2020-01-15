import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
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
            onPressed: this._completeOrder,
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.cancel,
            color: this.order.isCancelled ? Colors.red : Colors.grey,
            onPressed: this._cancelOrder,
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.monetization_on,
            color: this.order.isPaidFor ? Colors.blue : Colors.grey,
            onPressed: this._isOrderClosed() ? null : this._markOrderAsPaid,
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.money_off,
            color: this.order.isDiscounted ? Colors.blue : Colors.grey,
            onPressed: this._isOrderClosed()
                ? null
                : () async {
                    this._showDiscountDialog(context);
                  },
          ),
          SizedBox(
            width: 20.0,
          ),
          IconActionButton(
            icon: Icons.camera,
            color: Util.isEmptyOrNull(this.order.uniqueCode)
                ? Colors.grey
                : Colors.green,
            onPressed: this._isOrderClosed() ? null : this._scanUniqueCode,
          ),
        ],
      ),
    );
  }

  bool _isOrderClosed() {
    return this.order.isCompleted || this.order.isCancelled;
  }

  void _completeOrder() {
    this.order.isCompleted = !this.order.isCompleted;
    if (this.order.isCompleted) {
      this.order.completedTimestamp = DateTime.now().toUtc().toIso8601String();
      FirebaseService.closeOrder(this.order);
    } else {
      FirebaseService.openOrder(this.order);
    }
  }

  void _cancelOrder() {
    this.order.isCancelled = !this.order.isCancelled;
    if (this.order.isCancelled) {
      this.order.completedTimestamp = DateTime.now().toUtc().toIso8601String();
      FirebaseService.closeOrder(this.order);
    } else {
      FirebaseService.openOrder(this.order);
    }
  }

  void _markOrderAsPaid() {
    this.order.isPaidFor = !this.order.isPaidFor;
    FirebaseService.updateOpenOrder(this.order);
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

  void _scanUniqueCode() async {
    try {
      String scannedResult = await scanner.scan();
      if (scannedResult != null && Util.isValidUniqueCode(scannedResult)) {
        this.order.uniqueCode = scannedResult;
        FirebaseService.updateOpenOrder(this.order);
      }
    } catch (e) {
      return;
    }
  }
}
