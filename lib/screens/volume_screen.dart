import 'package:calculator/provider/volume_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolumeScreen extends StatelessWidget {
  const VolumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VolumeProvider(),
      child: const ConverterScreen<VolumeProvider>(title: 'Size'),
    );
  }
}
