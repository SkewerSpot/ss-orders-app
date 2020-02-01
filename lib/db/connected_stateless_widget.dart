import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ss_orders/db/firebase_service.dart';

/// Represents a [StatelessWidget] that fetches data from database,
/// and so is connected to it.
/// In our case, database means Firebase Realtime database.
///
/// Any [Widget] that extends [ConnectedStatelessWidget] must
/// be passed an instance of [FirebaseService].
/// Receiving this instance from outside improves testability of
/// the extending widget.
abstract class ConnectedStatelessWidget extends StatelessWidget {
  /// Instance of FirebaseService to allow calling database methods.
  final FirebaseService firebaseService;

  ConnectedStatelessWidget({@required this.firebaseService});
}
