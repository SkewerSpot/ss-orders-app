import 'package:flutter/material.dart';

// Theme colors
const Color kThemeColorWhite = Colors.white;
const Color kThemeColorYellow = Color(0xFFFCCA30);
const Color kThemeColorRed = Color(0xFFE73930);
const Color kThemeColorPurple = Color(0xFF7D88ED);

// Heading styles
const TextStyle kHeadingStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubHeadingStyle = TextStyle(
  fontSize: 18.0,
);

// Tax rates
const double kTaxRateCGST = 0.025;
const double kTaxRateSGST = 0.025;
const double kTaxRateGST = 0.05;

// Order views
Map<String, String> kOrdersViewTypes = {
  'open': 'Open',
  'closed': 'Closed',
};
