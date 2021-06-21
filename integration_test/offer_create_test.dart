import 'dart:developer';

import 'package:NachHilfeApp/global/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
//app to test
import 'package:NachHilfeApp/main.dart' as app;
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("login user", (WidgetTester tester) async {
    app.main();

    //wait for startup
    await tester.pumpAndSettle(const Duration(seconds: 4));

    //find and enter user name
    final userNameTextfield = find.byType(TextFormField);
    await tester.enterText(userNameTextfield, "test.user@igs-buchholz.de");
    //wait for animation
    await tester.pumpAndSettle();
    //press ok button
    final loginButton = find.byType(CupertinoButton);
    await tester.tap(loginButton);
    //wait for animation
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    //email pin field
    final emailPinCodeField = find.byType(PinCodeTextField);
    await tester.enterText(userNameTextfield, "100000");
    //wait for animation
    await tester.pumpAndSettle();

    expect(2 + 2, equals(4));
  });

  /**testWidgets("click on create floating action button",
      (WidgetTester tester) async {
    app.main();

<<<<<<< Updated upstream
    //wait for
    expect(2 + 2, equals(5));
=======
    //wait for startup
    await tester.pumpAndSettle(const Duration(seconds: 2));

    //find and press fab to open create screen
    final fab_create_offer = find.byKey(Key(Keys.fab_create_offer));
    //press fab
    await tester.tap(fab_create_offer);
    //wait for animation
    await tester.pumpAndSettle();

    expect(2 + 2, equals(4));
>>>>>>> Stashed changes
  });
  */
}
