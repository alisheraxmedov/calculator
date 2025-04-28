import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class TemperatureProvider extends ChangeNotifier {
  String fromUnit = 'Celsius °C';
  String toUnit = 'Fahrenheit °F';
  String input = '0';
  String output = '32';
  bool isResultDisplayed = false;

  final List<String> units = [
    'Celsius °C',
    'Fahrenheit °F',
    'Kelvin K',
  ];

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

      double celsiusValue;
      switch (fromUnit) {
        case 'Celsius °C':
          celsiusValue = result;
          break;
        case 'Fahrenheit °F':
          celsiusValue = (result - 32) * 5 / 9;
          break;
        case 'Kelvin K':
          celsiusValue = result - 273.15;
          break;
        default:
          celsiusValue = result;
      }

      double convertedValue;
      switch (toUnit) {
        case 'Celsius °C':
          convertedValue = celsiusValue;
          break;
        case 'Fahrenheit °F':
          convertedValue = celsiusValue * 9 / 5 + 32;
          break;
        case 'Kelvin K':
          convertedValue = celsiusValue + 273.15;
          break;
        default:
          convertedValue = celsiusValue;
      }

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
