import 'package:calculator/consts/colors.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.038,
              vertical: width * 0.05,
            ),
            child: Text(
              context.watch<ProviderClass>().result,
              style: TextStyle(
                color: ColorClass.white,
                fontSize: width * 0.07,
              ),
            ),
          ),
        ),
        const Divider(
          color: ColorClass.orginalGrey,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: '7',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("7");
                  },
                ),
                ButtonWidget(
                  text: '8',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("8");
                  },
                ),
                ButtonWidget(
                  text: '9',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("9");
                  },
                ),
                ButtonWidget(
                  text: '÷',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("÷");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: '4',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("4");
                  },
                ),
                ButtonWidget(
                  text: '5',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("5");
                  },
                ),
                ButtonWidget(
                  text: '6',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("6");
                  },
                ),
                ButtonWidget(
                  text: '×',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("×");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: '1',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("1");
                  },
                ),
                ButtonWidget(
                  text: '2',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("2");
                  },
                ),
                ButtonWidget(
                  text: '3',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("3");
                  },
                ),
                ButtonWidget(
                  text: '-',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("-");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: 'C',
                  color: ColorClass.orginalGrey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("C");
                  },
                ),
                ButtonWidget(
                  text: '0',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("0");
                  },
                ),
                ButtonWidget(
                  text: '=',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("=");
                  },
                ),
                ButtonWidget(
                  text: '+',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().solveResult("+");
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
