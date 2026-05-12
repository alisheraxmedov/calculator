import 'package:calculator/provider/provider.dart';
import 'package:calculator/screens/one.dart';
import 'package:calculator/widgets/drawer.dart';
import 'package:calculator/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            width: width,
            text: 'Calculator',
            fontSize: width * 0.08,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            Selector<ProviderClass, bool>(
              selector: (_, p) => p.isLight,
              builder: (context, isLight, _) => IconButton(
                onPressed: context.read<ProviderClass>().changeTheme,
                icon: Icon(
                  isLight ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        drawer: DrawerWidget(width: width),
        body: const FirstScreen(),
      ),
    );
  }
}
