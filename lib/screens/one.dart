import 'package:calculator/consts/colors.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.038,
                  vertical: width * 0.05,
                ),
                child: Text(
                  context.watch<ProviderClass>().oldInput,
                  style: TextStyle(
                    color: ColorClass.grey,
                    fontSize: width * 0.065,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.038,
                  vertical: width * 0.05,
                ),
                child: Text(
                  context.watch<ProviderClass>().output,
                  style: TextStyle(
                    color: ColorClass.white,
                    fontSize: width * 0.085,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: ColorClass.orginalGrey,
        ),
        Column(
          children: [
//=========================================================================
//=============================== << 1 >> =================================
//=========================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: '⨉',
                  color: ColorClass.orginalGrey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("⨉");
                  },
                ),
                ButtonWidget(
                  text: 'C',
                  color: ColorClass.orginalGrey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("C");
                  },
                ),
                ButtonWidget(
                  text: '(',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("(");
                  },
                ),
                ButtonWidget(
                  text: ')',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed(")");
                  },
                ),
                ButtonWidget(
                  text: 'π',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("π");
                  },
                ),
              ],
            ),
//=========================================================================
//=============================== << 2 >> =================================
//=========================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: 'sin',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("sin");
                  },
                ),
                ButtonWidget(
                  text: 'cos',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("cos");
                  },
                ),
                ButtonWidget(
                  text: 'tan',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("tan");
                  },
                ),
                ButtonWidget(
                  text: 'ctan',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("ctan");
                  },
                ),
                ButtonWidget(
                  text: '÷',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("/");
                  },
                ),
              ],
            ),
//=========================================================================
//=============================== << 3 >> =================================
//=========================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: '^2',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("^2");
                  },
                ),
                ButtonWidget(
                  text: '7',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("7");
                  },
                ),
                ButtonWidget(
                  text: '8',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("8");
                  },
                ),
                ButtonWidget(
                  text: '9',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("9");
                  },
                ),
                ButtonWidget(
                  text: '×',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("×");
                  },
                ),
              ],
            ),
//=========================================================================
//=============================== << 4 >> =================================
//=========================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: '^n',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("^");
                  },
                ),
                ButtonWidget(
                  text: '4',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("4");
                  },
                ),
                ButtonWidget(
                  text: '5',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("5");
                  },
                ),
                ButtonWidget(
                  text: '6',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("6");
                  },
                ),
                ButtonWidget(
                  text: '+',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("+");
                  },
                ),
              ],
            ),
//=========================================================================
//=============================== << 5 >> =================================
//=========================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: 'n!',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("!");
                  },
                ),
                ButtonWidget(
                  text: '1',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("1");
                  },
                ),
                ButtonWidget(
                  text: '2',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("2");
                  },
                ),
                ButtonWidget(
                  text: '3',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("3");
                  },
                ),
                ButtonWidget(
                  text: '-',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("-");
                  },
                ),
              ],
            ),
//=========================================================================
//=============================== << 6 >> =================================
//=========================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: ' %',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("%");
                  },
                ),
                ButtonWidget(
                  text: '0',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("0");
                  },
                ),
                ButtonWidget(
                  text: '.',
                  color: ColorClass.grey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed(".");
                  },
                ),
                ButtonWidget(
                  text: '=',
                  color: ColorClass.orginalGrey,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("="); // ❌
                  },
                ),
                ButtonWidget(
                  text: '√',
                  color: ColorClass.orange,
                  onPressed: () {
                    context.read<ProviderClass>().buttonPressed("√");
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
