import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/models/app_state.dart';
import 'package:ss_orders/screens/orders_screen.dart';
import 'package:ss_orders/screens/validate_code_screen.dart';

void main() => runApp(SSOrdersApp());

class SSOrdersApp extends StatefulWidget {
  @override
  _SSOrdersAppState createState() => _SSOrdersAppState();
}

class _SSOrdersAppState extends State<SSOrdersApp> {
  AppState appState = AppState();

  @override
  void initState() {
    super.initState();

    this.appState.setTab(kOrdersViewTypes.keys.first);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => this.appState,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        routes: {
          OrdersScreen.id: (context) => OrdersScreen(),
          ValidateCodeScreen.id: (context) => ValidateCodeScreen(),
        },
        initialRoute: OrdersScreen.id,
      ),
    );
  }
}
