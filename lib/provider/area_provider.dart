import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class AreaProvider extends ChangeNotifier {
  String fromUnit = 'Square meter m²';
  String toUnit = 'Square kilometer km²';
  String input = '1';
  String output = '0.000001';
  bool isResultDisplayed = false;

  final List<String> units = [
    'Square meter m²',
    'Square kilometer km²',
    'Square centimeter cm²',
    'Square millimeter mm²',
    'Hectare ha',
  ];

  // Birliklarni kvadrat metrga nisbatan koeffitsiyentlari
  final Map<String, double> unitFactors = {
    'Square meter m²': 1.0,
    'Square kilometer km²': 0.000001,
    'Square centimeter cm²': 10000.0,
    'Square millimeter mm²': 1000000.0,
    'Hectare ha': 0.0001,
  };

  void buttonPressed(String btnText) {
    if (btnText == 'C') {
      input = '0';
      isResultDisplayed = false;
    } else if (btnText == '⌫') {
      if (input.length > 1) {
        input = input.substring(0, input.length - 1);
      } else {
        input = '0';
      }
      isResultDisplayed = false;
    } else if (btnText == '=') {
      _calculateExpression();
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '×' ||
        btnText == '÷') {
      if (isResultDisplayed) {
        isResultDisplayed = false;
        input += btnText;
      } else {
        if (input.isNotEmpty &&
            (input[input.length - 1] == '+' ||
                input[input.length - 1] == '-' ||
                input[input.length - 1] == '×' ||
                input[input.length - 1] == '÷')) {
          input = input.substring(0, input.length - 1) + btnText;
        } else {
          input += btnText;
        }
      }
    } else {
      if (isResultDisplayed) {
        input = '';
        isResultDisplayed = false;
      }
      if (input == '0' && btnText != '.') input = '';
      input += btnText;
    }
    notifyListeners();
  }

  void changeFromUnit(String? value) {
    fromUnit = value!;
    _calculateExpression();
    notifyListeners();
  }

  void changeToUnit(String? value) {
    toUnit = value!;
    _calculateExpression();
    notifyListeners();
  }

  void _calculateExpression() {
    try {
      final parser = ShuntingYardParser();
      Expression exp =
          parser.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());

      input =
          result.toStringAsFixed(6).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

      double m2Value = result / unitFactors[fromUnit]!;
      double convertedValue = m2Value * unitFactors[toUnit]!;

      output = convertedValue
          .toStringAsFixed(6)
          .replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
      isResultDisplayed = true;
    } catch (e) {
      output = '0';
      input = '0';
    }
    notifyListeners();
  }
}
