import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

class ProviderClass extends ChangeNotifier {
  String input = '';
  String output = '0';

  // Har bir tugma bosilganda ishlaydigan funksiya
  void buttonPressed(String btnText) {
    if (btnText == 'C') {
      // Clear
      input = '';
      output = '0';
    } else if (btnText == '=') {
      _calculateResult();
    } else if (btnText == 'sin' ||
        btnText == 'cos' ||
        btnText == 'tan' ||
        btnText == 'ctan' ||
        btnText == 'n!' ||
        btnText == '^2' ||
        btnText == '^n' ||
        btnText == '√') {
      // Maxsus funksiyalarni bajarish
      _handleSpecialFunction(btnText);
    } else if (_isOperator(btnText)) {
      // Agar amal kiritilgan bo‘lsa, oxirgi amalni almashtirish
      if (input.isNotEmpty && _isOperator(input[input.length - 1])) {
        input = input.substring(0, input.length - 1) + btnText;
      } else {
        input += btnText;
      }
      output = input;
    } else if (btnText == '⨉') {
      // Oxiridan bitta element o‘chirish
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        output = input.isEmpty ? '0' : input;
      }
    } else {
      // Oddiy amal yoki raqam qo‘shish
      input += btnText;
      output = input;
    }
    notifyListeners();
  }

  bool _isOperator(String s) {
    return s == '+' || s == '-' || s == '×' || s == '/';
  }

  // Natijani hisoblash
  void _calculateResult() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(input);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);
      output = eval.toString();
      input = output;
    } catch (e) {
      output = 'Error';
      input = '';
    }
  }

  // Maxsus funksiyalarni bajarish
  void _handleSpecialFunction(String function) {
    try {
      double value = double.parse(input);
      switch (function) {
        case 'sin':
          // output = sin(value * pi / 180).toString(); // Radyanlar bilan sin
          output += "sin($value)";
          break;
        case 'cos':
          output = cos(value * pi / 180).toString(); // Radyanlar bilan cos
          break;
        case 'tan':
          output = tan(value * pi / 180).toString(); // Radyanlar bilan tan
          break;
        case 'ctan':
          output =
              (1 / tan(value * pi / 180)).toString(); // Radyanlar bilan ctan
          break;
        case '^2':
          output = pow(value, 2).toString(); // Kvadrat
          break;
        case '^n':
          // Siz n qiymatini keyin qo‘shishingiz mumkin
          input += '^';
          output = input;
          return;
        case 'n!':
          output = _factorial(value.toInt()).toString(); // Faktorial
          break;
        case '√':
          output = sqrt(value).toString(); // Ildiz
          break;
      }
      input = output;
    } catch (e) {
      output = 'Error';
      input = '';
    }
  }

  // Faktorial hisoblash
  int _factorial(int num) {
    if (num <= 1) return 1;
    return num * _factorial(num - 1);
  }
}
