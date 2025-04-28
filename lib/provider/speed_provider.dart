import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SpeedProvider extends ChangeNotifier {
  String fromUnit = 'Meter/second m/s';
  String toUnit = 'Kilometre/hour km/h';
  String input = '1';
  String output = '3.6';
  bool isResultDisplayed = false;

  final List<String> units = [
    'Meter/second m/s',
    'Kilometre/hour km/h',
    'Mile/hour mph',
    'Foot/second ft/s',
  ];

// Factors of units relative to meters/second
  final Map<String, double> unitFactors = {
    'Meter/second m/s': 1.0,
    'Kilometre/hour km/h': 3.6,
    'Mile/hour mph': 2.23694,
    'Foot/second ft/s': 3.28084,
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

      double mpsValue = result / unitFactors[fromUnit]!;
      double convertedValue = mpsValue * unitFactors[toUnit]!;

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
