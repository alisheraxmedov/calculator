import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class VolumeProvider extends ChangeNotifier {
  String fromUnit = 'Cubic meter m³';
  String toUnit = 'Liter l';
  String input = '1';
  String output = '1000';
  bool isResultDisplayed = false;

  final List<String> units = [
    'cubic meter m³',
    'Liter l',
    'Milliliter ml',
    'Cubic centimeter cm³',
    'Cubic decimeter dm³',
  ];

// Coefficients of units to cubic meters
  final Map<String, double> unitFactors = {
    'cubic meter m³': 1.0,
    'Liter l': 1000.0,
    'Milliliter ml': 1000000.0,
    'Cubic centimeter cm³': 1000000.0,
    'Cubic decimeter dm³': 1000.0,
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

      double m3Value = result / unitFactors[fromUnit]!;
      double convertedValue = m3Value * unitFactors[toUnit]!;

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
