import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:ss_orders/db/firebase_service.dart';
import 'package:ss_orders/models/app_state.dart';
import 'package:ss_orders/models/unique_code_meta.dart';
import 'package:ss_orders/widgets/text_tag.dart';
import 'package:ss_orders/widgets/unique_code_input_box.dart';

import '../mock_firebase_service.dart';

void main() {
  group('UniqueCodeInputBox widget', () {
    testWidgets('does not add an incomplete unique code to review',
        (WidgetTester tester) async {
      var incompleteUniqueCode = '1234';
      var mockFirebaseService = MockFirebaseService();

      await tester.pumpWidget(
          uniqueCodeInputBoxWrapper(mockService: mockFirebaseService));

      await tester.enterText(find.byType(TextField), incompleteUniqueCode);

      expect(find.byType(TextTag), findsNothing);
    });

    testWidgets(
        'displays an error message when an not-yet-generated unique code is given',
        (WidgetTester tester) async {
      var unGeneratedUniqueCode = '999999';
      var mockFirebaseService = MockFirebaseService();

      when(mockFirebaseService.getUniqueCodeMeta(unGeneratedUniqueCode))
          .thenAnswer((invocation) => Future.value(metaWithoutPath()));

      await tester.pumpWidget(
          uniqueCodeInputBoxWrapper(mockService: mockFirebaseService));

      await tester.enterText(find.byType(TextField), unGeneratedUniqueCode);

      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('adds a valid unique code to review',
        (WidgetTester tester) async {
      var validUniqueCode = '100471';
      var mockFirebaseService = MockFirebaseService();

      when(mockFirebaseService.getUniqueCodeMeta(validUniqueCode))
          .thenAnswer((invocation) => Future.value(metaWithPath()));

      await tester.pumpWidget(
          uniqueCodeInputBoxWrapper(mockService: mockFirebaseService));

      await tester.enterText(find.byType(TextField), validUniqueCode);

      await tester.pump();

      expect(find.byType(TextTag), findsOneWidget);
    });
  });
}

Widget uniqueCodeInputBoxWrapper({@required FirebaseService mockService}) {
  var appState = AppState();
  return ChangeNotifierProvider(
    create: (context) => appState,
    child: MaterialApp(
      home: Scaffold(
        body: UniqueCodeInputBox(
          firebaseService: mockService,
        ),
      ),
    ),
  );
}

UniqueCodeMeta metaWithPath() {
  return UniqueCodeMeta(
    orderPath: '2020/01/01/<uuid>',
    isRedeemed: false,
    redeemedTimestamp: '',
  );
}

UniqueCodeMeta metaWithoutPath() {
  return UniqueCodeMeta(
    orderPath: '',
    isRedeemed: false,
    redeemedTimestamp: '',
  );
}
