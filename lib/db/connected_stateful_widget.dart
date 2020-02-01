import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ss_orders/db/firebase_service.dart';

/// Represents a [StatefulWidget] that fetches data from database,
/// and so is connected to it.
/// In our case, database means Firebase Realtime database.
///
/// Any [Widget] that extends [ConnectedStatefulWidget] must
/// be passed an instance of [FirebaseService].
/// Receiving this instance from outside improves testability of
/// the extending widget.
abstract class ConnectedStatefulWidget extends StatefulWidget {
  /// Instance of FirebaseService to allow calling database methods.
  final FirebaseService firebaseService;

  ConnectedStatefulWidget({@required this.firebaseService});
}
