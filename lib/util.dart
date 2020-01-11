import 'package:intl/intl.dart';

/// A collection of reusable utility functions.
class Util {
  /// Returns a "YEAR/MONTH/DATE" string for the given date.
  /// For example, "2019/10/22".
  ///
  /// Useful for creating Firebase database node path fragments.
  static String getYYYYMMDDDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  /// Returns true when the given string is empty or null.
  static bool isEmptyOrNull(String s) {
    return ['', null].contains(s);
  }
}
