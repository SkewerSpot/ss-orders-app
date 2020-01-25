import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/widgets/icon_action_buton.dart';

/// Displays unique code and associated data
/// about an order.
///
/// Note that the widget does not anticipate a [CustomerOrder] object
/// in its constructor.
/// Rather it expects unique code et al to be explicitly passed.
class UniqueCodeCard extends StatelessWidget {
  /// Unique code.
  final String code;

  /// Date when the code was attached to its order.
  final DateTime attachedAt;

  /// Date when the code was redeemed by customer.
  final DateTime redeemedAt;

  UniqueCodeCard({
    @required this.code,
    @required this.attachedAt,
    this.redeemedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: kThemeColorYellow,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Unique code ${this.code}'),
                Text('attached on ${Util.getYYYYMMDDDate(this.attachedAt)}'),
                Visibility(
                  visible: this.redeemedAt != null,
                  child: Text(
                      'redeemed on ${Util.getYYYYMMDDDate(this.redeemedAt)}'),
                ),
              ],
            ),
            IconActionButton(
              color: this.redeemedAt != null ? Colors.green : Colors.grey,
              icon: Icons.done,
              onPressed: this._toggleRedemptionStatus,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleRedemptionStatus() async {}
}
