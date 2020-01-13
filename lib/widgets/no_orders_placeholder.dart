import 'package:flutter/material.dart';

class NoOrdersPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.fastfood,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'No orders here. Come back later.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
