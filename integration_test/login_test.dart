import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logbox_academic/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Sign in test example", (WidgetTester tester) async {
    /* Setup the finder*/
    final Finder signInEmailField = find.byKey(Key('loginUserField'));
    final Finder signInPasswordField = find.byKey(Key('loginPassField'));
    final Finder signInSaveButton = find.byKey(Key('loginSignInButton'));
    final Finder homeUserNameText = find.byKey(Key('homeUserNameText'));

    await tester.pumpWidget(MyApp());

    /*
    * pumpAndSettle basically waits for all frames to finish rendering.
    * Meaning it also waits for all animations to finish.
    * */
    await tester.pumpAndSettle();

    await tester.tap(signInEmailField);
    await tester.enterText(signInEmailField, "paed@train.co.za");

    await tester.tap(signInPasswordField);
    await tester.enterText(signInPasswordField, "logbox123");

    await tester.tap(signInSaveButton);
    print("sign in tapped");

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(homeUserNameText, findsOneWidget);

    print("Looking for 'Paed Trainee'");
    Text text = homeUserNameText.evaluate().first.widget as Text;
    expect(text.data, 'Paed Trainee');
  });
}
