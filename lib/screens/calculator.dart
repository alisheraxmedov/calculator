import 'package:calculator/consts/colors.dart';
import 'package:calculator/screens/one.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: ColorClass.black,
        centerTitle: true,
        title: Text(
          "Calculator",
          style: TextStyle(
            color: ColorClass.white,
            fontSize: width * 0.09,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      backgroundColor: ColorClass.black,
      body: const FirstScreen(),
      // body: Consumer<ProviderClass>(
      //   builder: (context, value, child) {
      //     return PagesClass.pages[value.currentIndex];
      //   },
      // ),
    );
  }
}
