import 'package:flutter/foundation.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/unique_code_meta.dart';

class AppState extends ChangeNotifier {
  String _selectedTab = '';
  int _openOrdersCount = 0;
  Map<String, UniqueCodeMeta> _uniqueCodesUnderReview = {};
  FirebaseService _firebaseService = FirebaseService();

  /// Getter for selectedTab state.
  String get selectedTab {
    return this._selectedTab;
  }

  /// Getter for openOrdersCount state.
  int get openOrdersCount {
    return this._openOrdersCount;
  }

  /// Getter for uniqueCodesUnderReview state.
  Map<String, UniqueCodeMeta> get uniqueCodesUnderReview {
    return this._uniqueCodesUnderReview;
  }

  /// Marks the given tab (id) as the selected outlet,
  /// and triggers state change.
  void setTab(String id) {
    this._selectedTab = id;
    this.notifyListeners();
  }

  /// Sets the counter for open orders.
  void setOpenOrdersCount(int count) {
    this._openOrdersCount = count;
  }

  /// Adds the given unique code and its metadata to codes under review,
  /// and triggers state change.
  void addUniqueCodeToReview(String code, UniqueCodeMeta meta) {
    this._uniqueCodesUnderReview[code] = meta;
    this.notifyListeners();
  }

  /// Removes the given unique code from codes under review,
  /// and triggers state change.
  void removeUniqueCodeFromReview(String code) {
    this._uniqueCodesUnderReview.remove(code);
    this.notifyListeners();
  }

  /// Toggles the given unique code's redeemed status,
  /// and triggers state change.
  ///
  /// This effectively toggles the code metadata's
  /// `isRedeemed` property and sets `redeemedTimestamp` accordingly.
  void toggleUniqueCodeRedeemedStatus(String code) async {
    var oldMeta = this._uniqueCodesUnderReview[code];

    var newMeta = UniqueCodeMeta(
      orderPath: oldMeta.orderPath,
      isRedeemed: !oldMeta.isRedeemed,
      redeemedTimestamp:
          !oldMeta.isRedeemed ? DateTime.now().toUtc().toIso8601String() : '',
    );

    var didUpdate = await this._firebaseService.updateUniqueCode(code, newMeta);

    if (didUpdate) {
      this._uniqueCodesUnderReview[code] = newMeta;
      this.notifyListeners();
    }
  }
}
