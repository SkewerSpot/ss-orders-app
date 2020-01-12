import 'package:flutter/material.dart';

/// A simple textless button identified only by its icon and color.
class IconActionButton extends StatelessWidget {
  const IconActionButton({
    @required this.icon,
    @required this.onPressed,
    @required this.color,
  });

  final IconData icon;
  final Color color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.0,
      height: 35.0,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        color: Color(0xFFF6F8FC),
        child: Icon(
          this.icon,
          size: 25.0,
          color: this.color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.0),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
