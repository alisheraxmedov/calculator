import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/screens/calculator.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderClass()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
          home: const CalculatorScreen(),
        );
      },
    );
  }
}
