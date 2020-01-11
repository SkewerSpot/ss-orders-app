import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/constants.dart';
import 'package:ss_orders/models/app_state.dart';

class TabButton extends StatelessWidget {
  final String id;
  final String text;

  TabButton({@required this.id, @required this.text});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    bool isActive = appState.selectedTab == this.id;

    return GestureDetector(
      onTap: () {
        appState.setTab(this.id);
      },
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
