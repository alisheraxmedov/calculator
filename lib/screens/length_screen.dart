import 'package:calculator/provider/length_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LengthScreen extends StatelessWidget {
  const LengthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LengthProvider(),
      child: const ConverterScreen<LengthProvider>(title: 'Length'),
    );
  }
}
