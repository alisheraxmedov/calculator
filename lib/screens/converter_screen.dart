import 'package:calculator/consts/colors.dart';
import 'package:calculator/provider/base_converter_provider.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConverterScreen<T extends BaseConverterProvider> extends StatelessWidget {
  final String title;
  const ConverterScreen({super.key, required this.title});

  static const List<List<String>> _keypad = [
    ['C', '⌫', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['00', '0', '.', '='],
  ];

  static const Set<String> _operators = {'+', '-', '×', '÷', '%'};
  static const Set<String> _accents = {'C', '⌫', '='};

  Color _colorFor(String label, ColorScheme scheme) {
    if (_accents.contains(label)) return scheme.onSecondary;
    if (_operators.contains(label)) return scheme.primary;
    return scheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(title),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.08),
              _UnitRow<T>(width: width, isFromUnit: true),
              SizedBox(height: width * 0.06),
              _UnitRow<T>(width: width, isFromUnit: false),
              SizedBox(height: width * 0.08),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (final row in _keypad)
                      Padding(
                        padding: EdgeInsets.only(bottom: width * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (final btn in row)
                              ButtonWidget(
                                text: btn,
                                color: _colorFor(btn, colorScheme),
                                onPressed: () =>
                                    context.read<T>().buttonPressed(btn),
                              ),
                          ],
                        ),
                      ),
                    SizedBox(height: width * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnitRow<T extends BaseConverterProvider> extends StatelessWidget {
  final double width;
  final bool isFromUnit;
  const _UnitRow({required this.width, required this.isFromUnit});

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, _) {
        final value = isFromUnit ? provider.fromUnit : provider.toUnit;
        final display = isFromUnit ? provider.input : provider.output;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: value,
              items: provider.units
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(fontSize: width * 0.045),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: isFromUnit
                  ? provider.changeFromUnit
                  : provider.changeToUnit,
              underline: const SizedBox(),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  display,
                  style: TextStyle(
                    fontSize: width * 0.07,
                    color: ColorClass.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
