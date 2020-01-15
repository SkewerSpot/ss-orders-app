import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/models/app_state.dart';

import 'package:ss_orders/screens/orders_screen.dart';

void main() {
  testWidgets('OrdersScreen displays as expected', (WidgetTester tester) async {
    await tester.pumpWidget(orderScreenWrapper());

    final semHandle = tester.ensureSemantics();

    final openTabButton = find.text('Open');
    expect(openTabButton, findsOneWidget);
    expect(tester.getSemantics(openTabButton),
        matchesSemantics(hasTapAction: true));

    final closedTabButton = find.text('Closed');
    expect(closedTabButton, findsOneWidget);
    expect(tester.getSemantics(closedTabButton),
        matchesSemantics(hasTapAction: true));

    semHandle.dispose();
  });
}

Widget orderScreenWrapper() {
  var appState = AppState();
  return ChangeNotifierProvider(
    create: (context) => appState,
    child: MaterialApp(home: OrdersScreen()),
  );
}
