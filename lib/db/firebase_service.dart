import 'package:firebase_database/firebase_database.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/models/customer_order.dart';

/// The central service for everything Firebase.
///
/// Provides static methods to manage tokens and customer orders.
class FirebaseService {
  /// Private central reference to our realtime database instance.
  static final _databaseRef = FirebaseDatabase.instance.reference();

  /// Returns open orders for the present day.
  static Stream<List<CustomerOrder>> getOpenOrders() {
    return _databaseRef.child('open-orders').onValue.map((event) {
      List<CustomerOrder> orders = [];
      Map data = event.snapshot.value;

      if (data != null) {
        orders = data.values
            .map((orderMap) => CustomerOrder.fromMap(orderMap))
            .toList();
      }

      return orders;
    });
  }
}
