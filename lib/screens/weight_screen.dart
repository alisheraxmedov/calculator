import 'package:calculator/provider/weight_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeightProvider(),
      child: const ConverterScreen<WeightProvider>(title: 'Weight'),
    );
  }
}
