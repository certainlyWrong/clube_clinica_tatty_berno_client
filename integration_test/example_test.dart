import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:looplus_core/app/modules/home/view/widgets/home_widget.dart';
import 'package:looplus_core/app/modules/search/view/search_page.dart';
import 'package:looplus_core/app/shared/widgets/grid_store_card_widget.dart';
import 'package:looplus_core/looplus_core.dart';

takeScreenShot({binding, tester, String? screenShotName}) async {
  if (kIsWeb) {
    await binding.takeScreenshot(screenShotName);
    return;
  } else if (Platform.isAndroid) {
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
  }
  await binding.takeScreenshot(screenShotName);
}

void main() {
  //step 1 Initialize
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("screenshots", () {
    testWidgets("Run screenshots", (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(
        AppWidget(
          endpoints: LoopCoreEndpoints(
            clientDomain: 'demo.loopmais.com.br',
            apiUrl: 'https://api.loopmais.net.br/api/v1',
            storageUrl: 'https://storage.googleapis.com/loopmais',
          ),
          enableGeolocation: false,
        ),
      );

      tester.printToConsole('Successfully open AppWidget');

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      await takeScreenShot(
        binding: binding,
        tester: tester,
        screenShotName: "splash_screen",
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      tester.printToConsole('Successfully open SplashScreen');

      Finder homeFinder = find.byType(HomeWidget);

      while (homeFinder.evaluate().isEmpty) {
        await tester.pumpAndSettle(const Duration(milliseconds: 800));
        homeFinder = find.byType(HomeWidget);
      }

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      await takeScreenShot(
        binding: binding,
        tester: tester,
        screenShotName: "home_screen",
      );

      Finder gridStoreCardWidgets = find.byType(GridStoreCardWidget);

      tester.tap(gridStoreCardWidgets.first);

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      await takeScreenShot(
        binding: binding,
        tester: tester,
        screenShotName: "store_screen",
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 800));

      Finder searchFinder = find.byType(SearchPage);

      while (searchFinder.evaluate().isEmpty) {
        await tester.pumpAndSettle(const Duration(milliseconds: 800));
        searchFinder = find.byType(SearchPage);
      }

      await takeScreenShot(
        binding: binding,
        tester: tester,
        screenShotName: "store_screen",
      );

      tester.printToConsole('Successfully open Login Page');
    });
  });
}
