import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String _selectedTab = '';
  int _openOrdersCount = 0;

  /// Getter for selectedTab state.
  String get selectedTab {
    return this._selectedTab;
  }

  /// Getter for openOrdersCount state.
  int get openOrdersCount {
    return this._openOrdersCount;
  }

  /// Marks the given tab (id) as the selected outlet,
  /// and triggers state change.
  void setTab(String id) {
    this._selectedTab = id;
    this.notifyListeners();
  }

  /// Sets the counter for open orders,
  /// and triggers state change.
  void setOpenOrdersCount(int count) {
    this._openOrdersCount = count;
  }
}
