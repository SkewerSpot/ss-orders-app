import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/app_state.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/widgets/orders_container_alt.dart';
import 'package:ss_orders/widgets/unique_code_input_box.dart';

class ValidateCodeScreen extends StatelessWidget {
  static final String id = 'validate';

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);

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
            child: UniqueCodeInputBox(),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: FutureBuilder<List<CustomerOrder>>(
              future: Future.wait(
                  appState.uniqueCodesUnderReview.values.map((meta) async {
                var order = await FirebaseService.getOrder(meta.orderPath);
                return order;
              }).toList()),
              builder: (context, snapshot) {
                return OrdersContainerAlt(
                  orders: snapshot.data ?? [],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
