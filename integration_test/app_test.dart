import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:ditonton/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('end-to-end test', (tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();
    final Finder drawer = find.byType(CustomDrawer);

    // do

    // assert
    expect(drawer, findsOneWidget);
  });
}
