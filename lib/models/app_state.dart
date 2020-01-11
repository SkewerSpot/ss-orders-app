import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String _selectedTab = '';

  /// Getter for selectedTab state.
  String get selectedTab {
    return this._selectedTab;
  }

  /// Marks the given tab (id) as the selected outlet,
  /// and triggers state change.
  void setTab(String id) {
    this._selectedTab = id;
    this.notifyListeners();
  }
}
