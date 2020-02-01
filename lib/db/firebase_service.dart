import 'package:firebase_database/firebase_database.dart';
import 'package:ss_orders/models/unique_code_meta.dart';
import 'package:ss_orders/util.dart';
import 'package:ss_orders/models/customer_order.dart';

/// The central service for everything Firebase.
///
/// Provides static methods to manage tokens and customer orders.
class FirebaseService {
  /// Private central reference to our realtime database instance.
  final _databaseRef = FirebaseDatabase.instance.reference();

  /// Returns orders from given path.
  ///
  /// This is a generic method used by `getOpenOrders` and `getClosedOrders`.
  Stream<List<CustomerOrder>> getOrders(String path, bool orderByDesc) {
    return this._databaseRef.child(path).onValue.map((event) {
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
  Stream<List<CustomerOrder>> getOpenOrders() {
    return this.getOrders('open-orders', false);
  }

  /// Returns closed orders for the present day,
  /// from the last 2 hours.
  Stream<List<CustomerOrder>> getClosedOrders() {
    var now = DateTime.now();

    return this
        .getOrders('orders/${Util.getYYYYMMDDDate(now)}', true)
        .map((orders) => orders.where((order) {
              var orderTime = DateTime.parse(order.timestamp);

              if (now.difference(orderTime).inHours > 2) return false;

              return true;
            }).toList());
  }

  /// Replaces an order at its Firebase path with given object.
  ///
  /// Returns true is successful, false otherwise.
  Future<bool> updateOpenOrder(CustomerOrder order) async {
    try {
      await this
          ._databaseRef
          .child('open-orders/${order.orderId}')
          .set(order.toMap());
      if (!Util.isEmptyOrNull(order.uniqueCode)) {
        var orderDate = DateTime.parse(order.timestamp);
        await this._addUniqueCode(
            '${Util.getYYYYMMDDDate(orderDate)}/${order.orderId}',
            order.uniqueCode);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Moves the given order from "open orders"
  /// to present day's collection.
  ///
  /// Once an order is closed, the UI doesn't allow to make
  /// further amends to it. Closed orders may only be
  /// reopened (`isCompleted == false`) or
  /// uncancelled (`isCancelled == false`).
  ///
  /// Returns true if successful, false otherwise.
  Future<bool> closeOrder(CustomerOrder order) async {
    try {
      await this
          ._databaseRef
          .child(
              'orders/${Util.getYYYYMMDDDate(DateTime.now())}/${order.orderId}')
          .set(order.toMap());
      await this._databaseRef.child('open-orders/${order.orderId}').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Moves the given order from present day's collection
  /// to "open orders".
  ///
  /// This method reverses the action performed by `closeOrder`.
  /// At times it may be useful to reopen (`isCompleted == false`)
  /// or uncancel (`isCancelled == false`) an order to make amends.
  ///
  /// Returns true if successful, false otherwise.
  Future<bool> openOrder(CustomerOrder order) async {
    try {
      await this
          ._databaseRef
          .child('open-orders/${order.orderId}')
          .set(order.toMap());
      await this
          ._databaseRef
          .child(
              'orders/${Util.getYYYYMMDDDate(DateTime.now())}/${order.orderId}')
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Returns [UniqueCodeMeta] instance for given unique code.
  Future<UniqueCodeMeta> getUniqueCodeMeta(String code) async {
    try {
      var uniqueCodeMetaSnapshot =
          await this._databaseRef.child('/unique-codes/$code').once();
      var uniqueCodeMeta = UniqueCodeMeta.fromMap(uniqueCodeMetaSnapshot.value);
      return uniqueCodeMeta;
    } catch (e) {
      return null;
    }
  }

  /// Returns [CustomerOrder] instance for order at given path.
  Future<CustomerOrder> getOrder(String path) async {
    try {
      var orderSnapshot = await this._databaseRef.child('/orders/$path').once();
      var order = CustomerOrder.fromMap(orderSnapshot.value);
      return order;
    } catch (e) {
      return null;
    }
  }

  /// Replaces a unique code at its Firebase path with given metadata object.
  ///
  /// Returns true is successful, false otherwise.
  Future<bool> updateUniqueCode(String code, UniqueCodeMeta meta) async {
    try {
      await this._databaseRef.child('unique-codes/$code').set(meta.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Adds a unique code to the "unique-codes" map in Firebase.
  ///
  /// [orderPath] should be a valid Firebase path to an order,
  /// in the format "YYYY/MM/DD/<orderId>".
  ///
  /// Returns true if successful, false otherwise.
  Future<bool> _addUniqueCode(String orderPath, String code) async {
    try {
      var meta = UniqueCodeMeta(
        orderPath: orderPath,
        isRedeemed: false,
        redeemedTimestamp: '',
      );
      await this._databaseRef.child('unique-codes/$code').set(meta.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
