import 'package:flutter/foundation.dart';
import 'item_type.dart';

/// Data class to represent item in [CustomerOrder].
class OrderItem {
  /// Name of the item.
  final String name;

  /// Category the item belongs to.
  String category;

  /// Whether the item is non-vegetarian or vegetarian.
  bool isNonVeg;

  /// Price of item.
  final double price;

  /// List of supported syrups or sauces.
  List<String> syrups;

  /// List of supported toppings.
  List<String> toppings;

  /// Sequence number of item in its category.
  final int sequenceNum;

  /// A [MenuItem] may have multiple types/variants.
  /// This prop holds the user-selected type.
  ItemType selectedType;

  /// *DEPRECATED* Not in use.
  ///
  /// Whether the item is to be complimented with an ice cream scoop.
  bool withIceCream;

  /// Whether the item has been prepared.
  ///
  /// A [CustomerOrder] has [isCompleted] prop that represents
  /// the doneness of the whole order. [OrderItem]'s [isDone] prop
  /// represents the doneness of its item only.
  /// Useful to track the doneness of individual items in an order.
  final bool isDone;

  OrderItem({
    @required this.name,
    this.category = '',
    this.isNonVeg = false,
    @required this.price,
    this.syrups,
    this.toppings,
    this.sequenceNum = 0,
    this.selectedType,
    this.withIceCream = false,
    this.isDone = false,
  });

  /// Returns a deserialized instance of [OrderItem] from a Map.
  /// Useful for reading data from JSON or Firebase.
  factory OrderItem.fromMap(Map data) {
    data = data ?? {};

    return OrderItem(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      isNonVeg: data['isNonVeg'] ?? false,
      price: data['price'] is double
          ? data['price']
          : data['price'] is int ? (data['price'] as int).toDouble() : 0.0,
      syrups: data['syrups'] is List
          ? (data['syrups'] as List).map((s) => s.toString()).toList()
          : [],
      toppings: data['toppings'] is List
          ? (data['toppings'] as List).map((t) => t.toString()).toList()
          : [],
      sequenceNum: data['sequenceNum'] ?? 0,
      selectedType: ItemType.fromMap(data['selectedType']),
      withIceCream: data['withIceCream'] ?? false,
      isDone: data['isDone'] ?? false,
    );
  }

  /// Returns a [Map] representation of the object,
  /// that can be used as a serialized form for sending to Firebase.
  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'category': this.category,
      'isNonVeg': this.isNonVeg,
      'price': this.price,
      'syrups': this.syrups,
      'toppings': this.toppings,
      'sequenceNum': this.sequenceNum,
      'selectedType':
          this.selectedType != null ? this.selectedType.toMap() : null,
      'withIceCream': this.withIceCream,
      'isDone': this.isDone,
    };
  }
}
