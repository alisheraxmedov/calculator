import 'dart:async';

import 'package:calculator/firebase_options.dart';
import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/screens/calculator.dart';
import 'package:calculator/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    await GetStorage.init();

    // Firebase init — sozlanmagan platformada silent fail
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      // Debug'da Crashlytics o'chirilgan — release'da yoqiladi
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    } catch (_) {
      // Firebase sozlanmagan — log emas, davom etamiz
    }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProviderClass()),
          ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    try {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } catch (_) {}
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ProviderClass, bool>(
      selector: (_, provider) => provider.isLight,
      builder: (context, isLight, _) {
        return MaterialApp(
          theme: isLight ? MyAppTheme.lightTheme : MyAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          home: const CalculatorScreen(),
        );
      },
    );
  }
}
