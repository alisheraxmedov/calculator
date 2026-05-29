import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/area_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AreaScreen extends StatelessWidget {
  const AreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AreaProvider(),
      child: ConverterScreen<AreaProvider>(
        title: AppLocalizations.of(context)!.screenSquare,
      ),
    );
  }
}
