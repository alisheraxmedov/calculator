import 'dart:math';

import 'package:calculator/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class ProviderClass extends ChangeNotifier {
//==================================================================
//========================= CHANGE THEME ===========================
//==================================================================

  final box = GetStorage();
  bool isLight = false;

  ProviderClass() {
    isLight = box.read<bool>('isLight') ?? false;
  }

  void changeTheme() {
    isLight = !isLight;
    box.write('isLight', isLight);
    notifyListeners();
  }

//==================================================================
//========================== MATH LOGIC ============================
//==================================================================
  String oldInput = '';
  String input = '';
  String output = '0';
  bool isResultDisplayed = false;
  bool isAdvancedMode = false;

  void buttonPressed(String btnText, BuildContext context) {
    if (btnText == 'C') {
      // Clear
      input = '';
      oldInput = '';
      output = '0';
      isResultDisplayed = false;
    } else if (btnText == '=') {
      _calculateResult(context);
    } else if (btnText == 'sin' ||
        btnText == 'cos' ||
        btnText == 'tan' ||
        btnText == 'ctan' ||
        btnText == 'n!' ||
        btnText == '^2' ||
        btnText == '^n' ||
        btnText == 'π' ||
        btnText == '√') {
      if (isResultDisplayed) {
        input = '';
        isResultDisplayed = false;
      }
      _appendSpecialFunction(btnText);
    } else if (_isOperator(btnText)) {
      if (isResultDisplayed) {
        isResultDisplayed = false;
      }
      if (input.isNotEmpty && _isOperator(input[input.length - 1])) {
        input = input.substring(0, input.length - 1) + btnText;
      } else {
        input += btnText;
      }
      output = input;
    } else if (btnText == '⨉') {
      // Oxiridan bitta element o'chirish
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        output = input.isEmpty ? '0' : input;
      }
    } else {
      // Oddiy amal yoki raqam qo'shish
      if (isResultDisplayed) {
        input = '';
        isResultDisplayed = false;
      }
      input += btnText;
      output = input;
    }
    notifyListeners();
  }

  bool _isOperator(String s) {
    return s == '+' || s == '-' || s == '×' || s == '/' || s == "%" || s == "π";
  }

  void _calculateResult(BuildContext context) {
    try {
      String expressionString = input.replaceAll('×', '*').replaceAll('÷', '/');

      if (expressionString.contains('%')) {
        expressionString = _handlePercentage(expressionString);
      }

      expressionString = expressionString.replaceAll('π', pi.toString());

      Parser parser = Parser();
      Expression expression = parser.parse(expressionString);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);
      output = eval.toString();
      
      // History ga saqlash
      context.read<HistoryProvider>().addHistory(input, output);
      
      input = output;
      oldInput = input;
      isResultDisplayed = true;
    } catch (e) {
      output = 'Improper use!';
      input = '';
      isResultDisplayed = false;
    }
  }

  String _handlePercentage(String expression) {
    final regExp = RegExp(r'(\d+(\.\d+)?)%\s*(\d+(\.\d+)?)');
    return expression.replaceAllMapped(regExp, (match) {
      final firstNum = match.group(1);
      final secondNum = match.group(3);
      return '($firstNum * ($secondNum / 100))';
    });
  }

  void _appendSpecialFunction(String function) {
    switch (function) {
      case 'sin':
        input += 'sin(';
        break;
      case 'cos':
        input += 'cos(';
        break;
      case 'tan':
        input += 'tan(';
        break;
      case 'ctan':
        input += '1/tan(';
        break;
      case '^2':
        input += '^2';
        break;
      case '^n':
        input += '^';
        break;
      case 'n!':
        input += '!';
        break;
      case '√':
        input += 'sqrt(';
        break;
      case 'π':
        input += 'π';
        break;
    }
    output = input;
    notifyListeners();
  }

  void toggleAdvancedMode() {
    isAdvancedMode = !isAdvancedMode;
    notifyListeners();
  }

  // History dan result qiymatini kalkulyatorga o'tkazish
  void setResultFromHistory(String result) {
    input = result;
    output = result;
    oldInput = '';
    isResultDisplayed = true;
    notifyListeners();
  }
}
