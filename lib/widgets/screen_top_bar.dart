import 'package:flutter/material.dart';

/// An [AppBar]-like widget typically shown at the top of a screen.
///
/// Displays app's brand name.
class ScreenTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Orders App',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30.0,
          ),
        ),
      ],
    );
  }
}
