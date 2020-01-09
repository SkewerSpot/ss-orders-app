import 'package:flutter/material.dart';
import 'package:ss_orders/screens/orders_screen.dart';

void main() => runApp(SSOrdersApp());

class SSOrdersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: {OrdersScreen.id: (context) => OrdersScreen()},
      initialRoute: OrdersScreen.id,
    );
  }
}
