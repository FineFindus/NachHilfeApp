import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
//app to test
import 'package:NachHilfeApp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("click on create floating action button",
      (WidgetTester tester) async {
    app.main();

    //wait for
    expect(2 + 2, equals(5));
  });
}
