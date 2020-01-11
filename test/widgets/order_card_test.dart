import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/models/order_item.dart';

import 'package:ss_orders/widgets/order_card.dart';
import 'package:ss_orders/widgets/order_item_card.dart';

void main() {
  testWidgets('OrderCard correctly displays an open order',
      (WidgetTester tester) async {
    var order = openOrder();

    await tester.pumpWidget(MaterialApp(home: OrderCard(order: order)));

    expect(find.byType(OrderItemCard), findsNWidgets(order.orderItems.length));

    expect(find.text(order.channel), findsOneWidget);

    expect(find.text(order.customerCarNum), findsNothing);
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
    orderItems: [
      OrderItem(name: 'Cheese Burst Pizza', price: 100.0),
      OrderItem(name: 'Super Duper Burger', price: 75.0),
    ],
  );
}
