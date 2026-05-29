import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/temperature_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TemperatureProvider(),
      child: ConverterScreen<TemperatureProvider>(
        title: AppLocalizations.of(context)!.screenTemperature,
      ),
    );
  }
}
