import 'package:firebase_database/firebase_database.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/models/customer_order.dart';

/// The central service for everything Firebase.
///
/// Provides static methods to manage tokens and customer orders.
class FirebaseService {
  /// Private central reference to our realtime database instance.
  static final _databaseRef = FirebaseDatabase.instance.reference();

  /// Returns orders from given path.
  ///
  /// This is a generic method used by `getOpenOrders` and `getClosedOrders`.
  static Stream<List<CustomerOrder>> getOrders(String path, bool orderByDesc) {
    return _databaseRef.child(path).onValue.map((event) {
      List<CustomerOrder> orders = [];
      Map data = event.snapshot.value;

      if (data != null) {
        orders = data.values
            .map((orderMap) => CustomerOrder.fromMap(orderMap))
            .toList();
      }

      // Order by 'token'
      if (orderByDesc == false)
        orders.sort((o1, o2) => o1.token.compareTo(o2.token)); // ASC
      else
        orders.sort((o1, o2) => o2.token.compareTo(o1.token)); // DESC

      return orders;
    });
  }

  /// Returns open orders for the present day.
  static Stream<List<CustomerOrder>> getOpenOrders() {
    return getOrders('open-orders', false);
  }

  /// Returns closed orders for the present day,
  /// from the last 2 hours.
  static Stream<List<CustomerOrder>> getClosedOrders() {
    var now = DateTime.now();

    return getOrders('orders/${Util.getYYYYMMDDDate(now)}', true)
        .map((orders) => orders.where((order) {
              var orderTime = DateTime.parse(order.timestamp);

              if (now.difference(orderTime).inHours > 2) return false;

              return true;
            }).toList());
  }
}
