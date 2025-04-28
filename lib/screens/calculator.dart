import 'package:calculator/provider/provider.dart';
import 'package:calculator/screens/one.dart';
import 'package:calculator/widgets/drawer.dart';
import 'package:calculator/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: TextWidget(
          width: width,
          text: "Calculator",
          fontSize: width * 0.09,
          letterSpacing: 1.0,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProviderClass>().changeTheme();
            },
            icon: Icon(
              context.watch<ProviderClass>().isLight
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(width: width),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: const FirstScreen(),
    );
  }
}
