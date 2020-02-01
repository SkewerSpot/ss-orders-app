import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/models/order_item.dart';

import 'package:ss_orders/widgets/order_card.dart';
import 'package:ss_orders/widgets/order_item_card.dart';

import '../mock_firebase_service.dart';

void main() {
  group('OrderCard widget', () {
    testWidgets('correctly displays an open order',
        (WidgetTester tester) async {
      var order = openOrder();

      await tester.pumpWidget(MaterialApp(
          home: OrderCard(
        order: order,
        firebaseService: MockFirebaseService(),
      )));

      expect(
          find.byType(OrderItemCard), findsNWidgets(order.orderItems.length));

      expect(find.text(order.channel), findsOneWidget);

      expect(find.text(order.customerCarNum), findsNothing);
    });

    testWidgets('correctly displays a completed order',
        (WidgetTester tester) async {
      var order = completedOrder();

      await tester.pumpWidget(MaterialApp(
          home: OrderCard(
        order: order,
        firebaseService: MockFirebaseService(),
      )));

      expect(
          find.byType(OrderItemCard), findsNWidgets(order.orderItems.length));

      expect(find.text(order.channel), findsOneWidget);

      expect(find.text(order.customerCarNum), findsNothing);
    });

    testWidgets('correctly displays a cancelled order',
        (WidgetTester tester) async {
      var order = cancelledOrder();

      await tester.pumpWidget(MaterialApp(
          home: OrderCard(
        order: order,
        firebaseService: MockFirebaseService(),
      )));

      expect(
          find.byType(OrderItemCard), findsNWidgets(order.orderItems.length));

      expect(find.text(order.channel), findsOneWidget);

      expect(find.text(order.customerCarNum), findsNothing);
    });
  });
}

CustomerOrder openOrder() {
  return CustomerOrder(
    orderId: '1',
    token: 1,
    channel: 'zomato',
    timestamp: DateTime.now().toIso8601String(),
    source: 'mr.test',
    customerName: 'Happy Singh',
    orderItems: [
      OrderItem(name: 'Cheese Burst Pizza', price: 100.0),
      OrderItem(name: 'Super Duper Burger', price: 75.0),
    ],
  );
}

CustomerOrder completedOrder() {
  return CustomerOrder(
    orderId: '1',
    token: 1,
    channel: 'zomato',
    timestamp: DateTime.now().toIso8601String(),
    source: 'mr.test',
    isCompleted: true,
    completedTimestamp:
        DateTime.now().add(Duration(minutes: 5)).toIso8601String(),
    orderItems: [
      OrderItem(name: 'Cheese Burst Pizza', price: 100.0),
      OrderItem(name: 'Super Duper Burger', price: 75.0),
    ],
  );
}

CustomerOrder cancelledOrder() {
  return CustomerOrder(
    orderId: '1',
    token: 1,
    channel: 'zomato',
    timestamp: DateTime.now().toIso8601String(),
    source: 'mr.test',
    isCancelled: true,
    completedTimestamp:
        DateTime.now().add(Duration(minutes: 5)).toIso8601String(),
    orderItems: [
      OrderItem(name: 'Cheese Burst Pizza', price: 100.0),
      OrderItem(name: 'Super Duper Burger', price: 75.0),
    ],
  );
}
