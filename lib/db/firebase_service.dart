import 'package:firebase_database/firebase_database.dart';

/// The central service for everything Firebase.
///
/// Provides static methods to manage tokens and customer orders.
class FirebaseService {
  /// Private central reference to our realtime database instance.
  static final _databaseRef = FirebaseDatabase.instance.reference();

  /// Returns open orders for the present day.
  static Stream<Map> getOpenOrders() {
    return _databaseRef
        .child('open-orders')
        .onValue
        .map((event) => event.snapshot.value ?? Map());
  }
}
