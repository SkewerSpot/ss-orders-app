import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/widgets/orders_container_alt.dart';
import 'package:ss_orders/widgets/unique_code_input_box.dart';

class ValidateCodeScreen extends StatelessWidget {
  static final String id = 'validate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColorYellow,
      appBar: AppBar(
        backgroundColor: kThemeColorYellow,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.cancel),
          color: kThemeColorRed,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: UniqueCodeInputBox(
              onUniqueCodeDetected: (codes) {},
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: OrdersContainerAlt(
              orders: [],
            ),
          )
        ],
      ),
    );
  }
}
