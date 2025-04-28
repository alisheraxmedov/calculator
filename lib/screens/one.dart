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
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.038,
                    vertical: width * 0.05,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      context.watch<ProviderClass>().oldInput,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: width * 0.065,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.038,
                    vertical: width * 0.05,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      context.watch<ProviderClass>().output,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: width * 0.085,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //=========================================================================
              //=============================== << 1 >> =================================
              //=========================================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                    text: '⨉',
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("⨉");
                    },
                  ),
                  ButtonWidget(
                    text: 'C',
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("C");
                    },
                  ),
                  ButtonWidget(
                    text: '(',
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("(");
                    },
                  ),
                  ButtonWidget(
                    text: ')',
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed(")");
                    },
                  ),
                  ButtonWidget(
                    text: 'π',
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("sin");
                    },
                  ),
                  ButtonWidget(
                    text: 'cos',
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("cos");
                    },
                  ),
                  ButtonWidget(
                    text: 'tan',
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("tan");
                    },
                  ),
                  ButtonWidget(
                    text: 'ctan',
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("ctan");
                    },
                  ),
                  ButtonWidget(
                    text: '÷',
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("^2");
                    },
                  ),
                  ButtonWidget(
                    text: '7',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("7");
                    },
                  ),
                  ButtonWidget(
                    text: '8',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("8");
                    },
                  ),
                  ButtonWidget(
                    text: '9',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("9");
                    },
                  ),
                  ButtonWidget(
                    text: '×',
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("^");
                    },
                  ),
                  ButtonWidget(
                    text: '4',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("4");
                    },
                  ),
                  ButtonWidget(
                    text: '5',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("5");
                    },
                  ),
                  ButtonWidget(
                    text: '6',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("6");
                    },
                  ),
                  ButtonWidget(
                    text: '+',
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("!");
                    },
                  ),
                  ButtonWidget(
                    text: '1',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("1");
                    },
                  ),
                  ButtonWidget(
                    text: '2',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("2");
                    },
                  ),
                  ButtonWidget(
                    text: '3',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("3");
                    },
                  ),
                  ButtonWidget(
                    text: '-',
                    color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("%");
                    },
                  ),
                  ButtonWidget(
                    text: '0',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("0");
                    },
                  ),
                  ButtonWidget(
                    text: '.',
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed(".");
                    },
                  ),
                  ButtonWidget(
                    text: '=',
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("="); // ❌
                    },
                  ),
                  ButtonWidget(
                    text: '√',
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<ProviderClass>().buttonPressed("√");
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
