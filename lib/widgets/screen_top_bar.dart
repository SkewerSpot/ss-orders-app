import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';

/// An [AppBar]-like widget typically shown at the top of a screen.
///
/// Displays app's brand name and validate unique code button.
class ScreenTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.transparent,
          onPressed: () {},
        ),
        Text(
          'Orders App',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30.0,
          ),
        ),
        IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.camera),
          color: kThemeColorPurple,
          onPressed: () {},
        ),
      ],
    );
  }
}
