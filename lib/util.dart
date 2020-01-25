import 'package:intl/intl.dart';

/// A collection of reusable utility functions.
class Util {
  /// Returns a "YEAR/MONTH/DATE" string for the given date.
  /// For example, "2019/10/22".
  ///
  /// Useful for creating Firebase database node path fragments.
  static String getYYYYMMDDDate(DateTime date) {
    if (date == null) return '';

    return DateFormat('yyyy/MM/dd').format(date);
  }

  /// Returns true when the given string is empty or null.
  static bool isEmptyOrNull(String s) {
    return ['', null].contains(s);
  }

  /// Returns true if given unique code is a string of 6 digits,
  /// much like a PIN or an OTP code.
  static bool isValidUniqueCode(String code) {
    return RegExp(r'^(\d{6})$').hasMatch(code);
  }
}
