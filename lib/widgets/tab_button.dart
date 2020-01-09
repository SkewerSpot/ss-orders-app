import 'package:flutter/material.dart';
import 'package:ss_orders/constants.dart';

class TabButton extends StatelessWidget {
  final String id;
  final String text;

  TabButton({@required this.id, @required this.text});

  @override
  Widget build(BuildContext context) {
    bool isActive = false;

    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Text(
            this.text,
            style: TextStyle(
              color: kThemeColorWhite,
              fontSize: 17.0,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Container(
            width: isActive ? 15.0 : 0.0,
            child: Divider(
              color: kThemeColorWhite,
              thickness: 3.0,
            ),
          ),
        ],
      ),
    );
  }
}
