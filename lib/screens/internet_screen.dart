import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/internet_provider.dart';
import 'package:calculator/screens/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InternetScreen extends StatelessWidget {
  const InternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InternetProvider(),
      child: ConverterScreen<InternetProvider>(
        title: AppLocalizations.of(context)!.screenInternet,
      ),
    );
  }
}
