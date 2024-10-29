import 'package:calculator/consts/colors.dart';
import 'package:calculator/consts/pages.dart';
import 'package:calculator/provider/provider.dart';
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
          bottom: PreferredSize(
            preferredSize: Size(
              width,
              width * 0.12,
            ),
            child: Container(
              color: ColorClass.black,
              height: width * 0.12,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: width * 0.4),
                  TextButton(
                    onPressed: () {
                      print("Simple");
                      context.read<ProviderClass>().changeIndex(0);
                    },
                    child: Text(
                      "Simple",
                      style: TextStyle(
                        color: ColorClass.white,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Experimentally");
                      context.read<ProviderClass>().changeIndex(1);
                    },
                    child: Text(
                      "Experimentally",
                      style: TextStyle(
                        color: ColorClass.white,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: ColorClass.black,
        body: Consumer<ProviderClass>(
          builder: (context, value, child) {
            return PagesClass.pages[value.currentIndex];
          },
        ));
  }
}
