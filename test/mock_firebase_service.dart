import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/customer_order.dart';
import 'package:ss_orders/models/unique_code_meta.dart';

class MockFirebaseService implements FirebaseService {
  @override
  Future<bool> closeOrder(CustomerOrder order) {
    // TODO: implement closeOrder
    return null;
  }

  @override
  Stream<List<CustomerOrder>> getClosedOrders() {
    // TODO: implement getClosedOrders
    return null;
  }

  @override
  Stream<List<CustomerOrder>> getOpenOrders() {
    // TODO: implement getOpenOrders
    return null;
  }

  @override
  Future<CustomerOrder> getOrder(String path) {
    // TODO: implement getOrder
    return null;
  }

  @override
  Stream<List<CustomerOrder>> getOrders(String path, bool orderByDesc) {
    // TODO: implement getOrders
    return null;
  }

  @override
  Future<UniqueCodeMeta> getUniqueCodeMeta(String code) {
    // TODO: implement getUniqueCodeMeta
    return null;
  }

  @override
  Future<bool> openOrder(CustomerOrder order) {
    // TODO: implement openOrder
    return null;
  }

  @override
  Future<bool> updateOpenOrder(CustomerOrder order) {
    // TODO: implement updateOpenOrder
    return null;
  }

  @override
  Future<bool> updateUniqueCode(String code, UniqueCodeMeta meta) {
    // TODO: implement updateUniqueCode
    return null;
  }
}
