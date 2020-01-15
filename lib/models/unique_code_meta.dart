import 'package:flutter/foundation.dart';

/// Metadata about a unique code.
class UniqueCodeMeta {
  /// Firebase path for the code's associated order.
  final String orderPath;

  /// Whether the code has been redeemed.
  final bool isRedeemed;

  /// Timestamp of date and time when the code was redeemed.
  /// Must be a valid ISO8601 string.
  String redeemedTimestamp;

  UniqueCodeMeta({
    @required this.orderPath,
    this.isRedeemed = false,
    this.redeemedTimestamp,
  });

  /// Returns a deserialized instance of [UniqueCodeMeta] from a Map.
  /// Useful for reading data from JSON or Firebase.
  factory UniqueCodeMeta.fromMap(Map data) {
    data = data ?? {};

    return UniqueCodeMeta(
      orderPath: data['orderPath'] ?? '',
      isRedeemed: data['isRedeemed'] ?? false,
      redeemedTimestamp: data['redeemedTimestamp'] ?? '',
    );
  }

  /// Returns a [Map] representation of the object,
  /// that can be used as a serialized form for sending to Firebase.
  Map<String, dynamic> toMap() {
    return {
      'orderPath': this.orderPath,
      'isRedeemed': this.isRedeemed,
      'redeemedTimestamp': this.redeemedTimestamp,
    };
  }
}
