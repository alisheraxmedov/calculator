import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class InternetProvider extends ChangeNotifier {
  String fromUnit = 'Megabyte MB';
  String toUnit = 'Gigabyte GB';
  String input = '1';
  String output = '0.001';
  bool isResultDisplayed = false;

  final List<String> units = [
    'Bit b',
    'Byte B',
    'kilobyte KB',
    'Megabyte MB',
    'Gigabyte GB',
    'Terabyte TB',
  ];

// Factors of units relative to bytes
  final Map<String, double> unitFactors = {
    'Bit b': 8.0,
    'Byte B': 1.0,
    'Kilobyte KB': 1 / 1024,
    'Megabyte MB': 1 / (1024 * 1024),
    'Gigabyte GB': 1 / (1024 * 1024 * 1024),
    'Terabyte TB': 1 / (1024 * 1024 * 1024 * 1024),
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

      double byteValue = result / unitFactors[fromUnit]!;
      double convertedValue = byteValue * unitFactors[toUnit]!;

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
