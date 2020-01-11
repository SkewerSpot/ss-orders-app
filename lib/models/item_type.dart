import 'package:flutter/foundation.dart';

/// A variant of a menu item.
///
/// A menu item may have multiple variants.
/// For example, sizes of a pizza,
/// quantity (half or full) of an Indian curry,
/// types of a waffle (square, stick, large, small), etc.
class ItemType {
  /// Name of the variant.
  final String name;

  /// Price of the variant.
  ///
  /// Note that this is the absolute price.
  /// NOT to be used for relative pricing.
  /// For example, "30 more than the base price."
  final double price;

  ItemType({@required this.name, @required this.price});

  /// Returns a deserialized instance of [ItemType] from a Map.
  /// Useful for reading data from JSON or Firebase.
  factory ItemType.fromMap(Map data) {
    data = data ?? {};

    return ItemType(
      name: data['name'] ?? '',
      price: data['price'] ?? 0.0,
    );
  }

  /// Returns a [Map] representation of the object,
  /// that can be used as a serialized form for sending to Firebase.
  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'price': this.price,
    };
  }
}
