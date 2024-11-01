import 'package:calculator/provider/provider.dart';
import 'package:calculator/screens/calculator.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderClass(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ProviderClass>().isLight
          ? MyAppTheme.lightTheme
          : MyAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}
