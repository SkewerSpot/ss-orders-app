import 'package:test/test.dart';
import 'package:ss_orders/util.dart';

void main() {
  group('Util.getYYYYMMDDDate', () {
    test('formats a valid date correctly', () {
      var date = DateTime.parse('2020-01-12');
      var formattedDate = Util.getYYYYMMDDDate(date);

      expect(formattedDate, '2020/01/12');
    });
  });

  group('Util.isEmptyOrNull', () {
    test('returns true for empty string', () {
      String emptyString = '';
      bool result = Util.isEmptyOrNull(emptyString);

      expect(result, true);
    });

    test('returns true for null', () {
      String nullString;
      bool result = Util.isEmptyOrNull(nullString);

      expect(result, true);
    });

    test('returns false for non-empty string', () {
      String nonEmptyString = 'abcdef';
      String seeminglyEmptyString = ' ';
      bool result1 = Util.isEmptyOrNull(nonEmptyString);
      bool result2 = Util.isEmptyOrNull(seeminglyEmptyString);

      expect(result1, false);
      expect(result2, false);
    });
  });

  group('Util.isValidUniqueCode', () {
    test('returns true for a 6-digit code', () {
      String validCode = '123456';
      bool result = Util.isValidUniqueCode(validCode);

      expect(result, true);
    });

    test('returns false for a code with less than 6 digits', () {
      String fiveDigitCode = '12345';
      bool result = Util.isValidUniqueCode(fiveDigitCode);

      expect(result, false);
    });

    test('returns false for a code with more than 6 digits', () {
      String sevenDigitCode = '1234567';
      bool result = Util.isValidUniqueCode(sevenDigitCode);

      expect(result, false);
    });

    test('returns false for a 6-character alphanumeric code', () {
      String sixCharAlphaNumCode = '1a2b3c';
      String almostSixDigitCode = '12345f';
      bool result1 = Util.isValidUniqueCode(sixCharAlphaNumCode);
      bool result2 = Util.isValidUniqueCode(almostSixDigitCode);

      expect(result1, false);
      expect(result2, false);
    });
  });
}
