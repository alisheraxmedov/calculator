import 'package:calculator/provider/time_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimeProvider(),
      child: const ConverterScreen<TimeProvider>(title: 'Time'),
    );
  }
}
