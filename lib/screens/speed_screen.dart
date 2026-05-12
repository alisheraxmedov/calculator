import 'package:calculator/provider/speed_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpeedScreen extends StatelessWidget {
  const SpeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpeedProvider(),
      child: const ConverterScreen<SpeedProvider>(title: 'Speed'),
    );
  }
}
