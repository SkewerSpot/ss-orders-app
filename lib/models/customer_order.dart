import 'package:flutter/foundation.dart';
import 'package:ss_orders/constants.dart';
import 'order_item.dart';

/// All data related to a customer's order.
///
/// Includes order items and customer details.
class CustomerOrder {
  /// A unique string id representative of the order.
  final String orderId;

  /// Name of the customer.
  final String customerName;

  /// Customer's mobile or contact number.
  final String customerMobile;

  /// Customer's car number.
  ///
  /// It's not unusual in Jalandhar for customers to order and enjoy food
  /// from the comfort of their cars parked just outside the outlet.
  final String customerCarNum;

  /// Model or make of the car.
  ///
  /// For example, "Honda City".
  final String customerCarMake;

  /// Additional notes or comments.
  ///
  /// Could be used to add customer specific notes.
  /// For example, "make the pizza spicy."
  final String customerComments;

  /// List of order items received from cart.
  final List<OrderItem> orderItems;

  /// Token number given to customer on successful placement of order.
  ///
  /// Used for queue control.
  final int token;

  /// The exact date and time of order.

  /// Must be a valid ISO8601 string.
  final String timestamp;

  /// *DEPRECATED* No longer used.
  final String timeOfDay;

  /// Whether payment (in any form) has been received for the order.
  bool isPaidFor;

  /// Whether the order has been payed for and delivered.
  bool isCompleted;

  /// Whether a receipt was issued to the customer.
  bool isReceiptIssued;

  /// The exact date and time when order was marked completed.
  ///
  /// The difference between [timestamp] and [completedTimestamp]
  /// is used to calculate total order preparation time by Orders and Stats apps.
  String completedTimestamp;

  /// Whether the order stands cancelled (for whatever reason).
  bool isCancelled;

  /// Whether a discount was applied to the order.
  bool isDiscounted;

  /// The discount amount applied to the order.
  double discountAmount;

  /// The channel from where the order was received.
  ///
  /// For example, "zomato", "swiggy", "instore", etc.
  final String channel;

  /// Central GST tax rate.
  final double taxRateCGST;

  /// State GST tax rate.
  final double taxRateSGST;

  /// Total GST tax rate (CGST+SGST).
  final double taxRateGST;

  /// Whether the order is inclusive or exclusive of taxes.
  ///
  /// It's a common practice to levy extra taxes for online orders,
  /// and include taxes in the price for in-store orders.
  final bool isInclusiveOfTaxes;

  /// Id of the app creating this order object.
  ///
  /// For example, "menuapp", "gmail2order", etc.
  final String source;

  /// A collectible unique code part of loyalty program.
  ///
  /// This is usually printed on a thank you note
  /// and scanned using qrcode reader.
  ///
  /// See: https://github.com/SkewerSpot/thankyou-gen
  String uniqueCode;

  CustomerOrder({
    @required this.orderId,
    this.customerName,
    this.customerMobile,
    this.customerCarNum,
    this.customerCarMake,
    this.customerComments,
    @required this.orderItems,
    @required this.token,
    this.timeOfDay,
    this.isPaidFor = false,
    this.isCompleted = false,
    this.isReceiptIssued = false,
    @required this.timestamp,
    this.completedTimestamp = '',
    this.isCancelled = false,
    this.isDiscounted = false,
    this.discountAmount = 0.0,
    @required this.channel,
    this.taxRateCGST = kTaxRateCGST,
    this.taxRateSGST = kTaxRateSGST,
    this.taxRateGST = kTaxRateGST,
    this.isInclusiveOfTaxes = false,
    @required this.source,
    this.uniqueCode,
  });

  /// Returns a deserialized instance of [CustomerOrder] from a Map.
  /// Useful for reading data from JSON or Firebase.
  factory CustomerOrder.fromMap(Map data) {
    data = data ?? {};

    return CustomerOrder(
      orderId: data['orderId'] ?? '',
      customerName: data['customerName'],
      customerMobile: data['customerMobile'],
      customerCarNum: data['customerCarNum'],
      customerCarMake: data['customerCarMake'],
      customerComments: data['customerComments'],
      orderItems: data['orderItems'] != null
          ? (data['orderItems'] as List)
              .map((itemMap) => OrderItem.fromMap(itemMap))
              .toList()
          : [],
      token: data['token'] ?? '',
      timeOfDay: data['timeOfDay'],
      isPaidFor: data['isPaidFor'] ?? false,
      isCompleted: data['isCompleted'] ?? false,
      isReceiptIssued: data['isReceiptIssued'] ?? false,
      timestamp: data['timestamp'] ?? '',
      completedTimestamp: data['completedTimestamp'] ?? '',
      isCancelled: data['isCancelled'] ?? false,
      isDiscounted: data['isDiscounted'] ?? false,
      discountAmount: data['discountAmount'] is double
          ? data['discountAmount']
          : data['discountAmount'] is String
              ? double.parse(data['discountAmount'])
              : data['discountAmount'] is int
                  ? (data['discountAmount'] as int).toDouble()
                  : 0.0,
      channel: data['channel'] ?? '',
      taxRateCGST: data['taxRateCGST'] ?? kTaxRateCGST,
      taxRateSGST: data['taxRateSGST'] ?? kTaxRateSGST,
      taxRateGST: data['taxRateGST'] ?? kTaxRateGST,
      isInclusiveOfTaxes: data['isInclusiveOfTaxes'] ?? false,
      source: data['source'] ?? '',
      uniqueCode: data['uniqueCode'],
    );
  }

  /// Returns a [Map] representation of the object,
  /// that can be used as a serialized form for sending to Firebase.
  Map<String, dynamic> toMap() {
    return {
      'orderId': this.orderId,
      'customerName': this.customerName,
      'customerMobile': this.customerMobile,
      'customerCarNum': this.customerCarNum,
      'customerCarMake': this.customerCarMake,
      'customerComments': this.customerComments,
      'orderItems': this.orderItems.map<Map>((item) => item.toMap()).toList(),
      'token': this.token,
      'timestamp': this.timestamp,
      'timeOfDay': this.timeOfDay,
      'isPaidFor': this.isPaidFor,
      'isCompleted': this.isCompleted,
      'isReceiptIssued': this.isReceiptIssued,
      'completedTimestamp': this.completedTimestamp,
      'isCancelled': this.isCancelled,
      'isDiscounted': this.isDiscounted,
      'discountAmount': this.discountAmount,
      'channel': this.channel,
      'taxRateCGST': this.taxRateCGST,
      'taxRateSGST': this.taxRateSGST,
      'taxRateGST': this.taxRateGST,
      'isInclusiveOfTaxes': this.isInclusiveOfTaxes,
      'source': this.source,
      'uniqueCode': this.uniqueCode,
    };
  }

  /// Returns the sum total of prices of all items in the order.
  /// Total value may be less than sum if order is inclusive of taxes.
  double totalCost() {
    if (this.orderItems.length < 1) return 0.0;

    double total = this
        .orderItems
        .map<double>((item) => item.price)
        .reduce((sum, currentPrice) => sum + currentPrice);

    if (this.isInclusiveOfTaxes) {
      total /= (1 + this.taxRateGST);
    }

    return total;
  }

  /// Returns the total amount of tax to be levied.
  double totalTax() {
    double taxableCost = this.totalCost() - this.discountAmount;
    double tax =
        (taxableCost * this.taxRateCGST) + (taxableCost * this.taxRateSGST);
    return tax;
  }

  /// Return the amount to be collected for this order from customer.
  ///
  /// Formula: receivable cost = total cost - discount + tax
  double totalReceivableCost() {
    return this.totalCost() - this.discountAmount + this.totalTax();
  }
}
