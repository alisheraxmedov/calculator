import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class LengthProvider extends ChangeNotifier {
  String fromUnit = 'Meter m';
  String toUnit = 'Centimeter cm';
  String input = '1';
  String output = '100';
  bool isResultDisplayed = false;

  final List<String> units = [
    'Meter m',
    'Centimeter cm',
    'Millimeter mm',
    'Kilometer km',
    'Inches in',
    'Foot ft',
    'Yard yd',
  ];

// Factors of units relative to meters
  final Map<String, double> unitFactors = {
    'Meter m': 1.0,
    'Centimeter cm': 100.0,
    'Millimeter mm': 1000.0,
    'Kilometer km': 0.001,
    'Inches in': 39.3701,
    'Foot ft': 3.28084,
    'Yard yd': 1.09361,
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
      // Agar natija ko'rsatilgan bo'lsa va operator bosilsa
      if (isResultDisplayed) {
        isResultDisplayed = false;
        // Operatorni qo'shish
        input += btnText;
      } else {
        // Agar oxirgi belgi operator bo'lsa, uni almashtirish
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
      // Matematik ifodani hisoblash
      final parser = ShuntingYardParser();
      Expression exp =
          parser.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());

      // Natijani input ga qo'yish
      input =
          result.toStringAsFixed(6).replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');

      // Konvertatsiya qilish
      double metrValue = result / unitFactors[fromUnit]!;
      double convertedValue = metrValue * unitFactors[toUnit]!;

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
