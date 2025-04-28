import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class TimeProvider extends ChangeNotifier {
  String fromUnit = 'Second s';
  String toUnit = 'Minute min';
  String input = '60';
  String output = '1';
  bool isResultDisplayed = false;

  final List<String> units = [
    'Millisecond ms',
    'Second s',
    'Minute min',
    'Hour h',
    'Day',
    'Week',
    'Month',
    'Year',
  ];

// Factors of units relative to seconds
  final Map<String, double> unitFactors = {
    'Millisecond ms': 1000.0,
    'Second s': 1.0,
    'Minute min': 0.0166667,
    'Hour h': 0.000277778,
    'Day': 0.0000115741,
    'Week': 0.00000165344,
    'Month': 0.000000380517,
    'Year': 0.0000000317098,
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

      double secondValue = result / unitFactors[fromUnit]!;
      double convertedValue = secondValue * unitFactors[toUnit]!;

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
