import 'package:calculator/provider/area_provider.dart';
import 'package:calculator/provider/bmi_provider.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/provider/internet_provider.dart';
import 'package:calculator/provider/length_provider.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/provider/speed_provider.dart';
import 'package:calculator/provider/temperature_provider.dart';
import 'package:calculator/provider/time_provider.dart';
import 'package:calculator/provider/volume_provider.dart';
import 'package:calculator/provider/weight_provider.dart';


import 'package:calculator/screens/calculator.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LengthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AreaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BMIProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => InternetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VolumeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WeightProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpeedProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TemperatureProvider(),
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
