import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';

/// Displays a simple tag-like widget
/// with text on left and a cancel button on right.
class TextTag extends StatelessWidget {
  /// The text to display.
  final String text;

  /// Action to perform on tap of cancel button.
  final Function onCancelPressed;

  TextTag({
    @required this.text,
    @required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 90.0,
      height: 30.0,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      margin: EdgeInsets.only(
        top: 10.0,
        left: 5.0,
        right: 5.0,
      ),
      decoration: BoxDecoration(
        color: kThemeColorPurple,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            this.text,
            style: TextStyle(
              color: kThemeColorWhite,
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.cancel,
              color: kThemeColorWhite,
              size: 16.0,
            ),
            onTap: this.onCancelPressed,
          )
        ],
      ),
    );
  }
}
