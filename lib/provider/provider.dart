import 'dart:math';

import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/services/review_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class ProviderClass extends ChangeNotifier {
  static final GrammarParser _parser = GrammarParser();
  static final RegExp _percentageRegex =
      RegExp(r'(\d+(\.\d+)?)%(\d+(\.\d+)?)?');

  static const Set<String> _operators = {'+', '-', '×', '÷', '/'};
  static const Set<String> _specialFunctions = {
    'sin', 'cos', 'tan', 'ctan', 'n!', '^2', '^n', 'π', '√',
  };

  final GetStorage _box = GetStorage();
  bool isLight;

  ProviderClass() : isLight = GetStorage().read<bool>('isLight') ?? false;

  void changeTheme() {
    isLight = !isLight;
    _box.write('isLight', isLight);
    notifyListeners();
  }

  String oldInput = '';
  String input = '';
  String output = '0';
  bool isResultDisplayed = false;
  bool isAdvancedMode = false;

  void buttonPressed(String btnText, BuildContext context) {
    if (btnText == 'C') {
      input = '';
      oldInput = '';
      output = '0';
      isResultDisplayed = false;
    } else if (btnText == '=') {
      _calculateResult(context);
    } else if (_specialFunctions.contains(btnText)) {
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
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        output = input.isEmpty ? '0' : input;
      }
    } else {
      if (isResultDisplayed) {
        input = '';
        isResultDisplayed = false;
      }
      input += btnText;
      output = input;
    }
    notifyListeners();
  }

  bool _isOperator(String s) => _operators.contains(s);

  void _calculateResult(BuildContext context) {
    try {
      var expressionString = input
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', pi.toString());

      if (expressionString.contains('%')) {
        expressionString = _handlePercentage(expressionString);
      }

      final double eval = (_parser
              .parse(expressionString)
              .evaluate(EvaluationType.REAL, ContextModel()) as num)
          .toDouble();

      if (!eval.isFinite) {
        throw const FormatException('Non-finite result');
      }

      output = eval == eval.truncate()
          ? eval.truncate().toString()
          : eval.toString();

      context.read<HistoryProvider>().addHistory(input, output);

      oldInput = input;
      input = output;
      isResultDisplayed = true;

      // Rating boost — 7-marta muvaffaqiyatli hisoblanganidan keyin so'raymiz
      ReviewService.registerCalculation();
    } catch (_) {
      output = AppLocalizations.of(context)?.improperUse ?? 'Improper use!';
      input = '';
      isResultDisplayed = false;
    }
  }

  String _handlePercentage(String expression) {
    return expression.replaceAllMapped(_percentageRegex, (match) {
      final firstNum = match.group(1);
      final secondNum = match.group(3);
      if (secondNum == null) return '($firstNum/100)';
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
  }

  void toggleAdvancedMode() {
    isAdvancedMode = !isAdvancedMode;
    notifyListeners();
  }

  void setResultFromHistory(String result) {
    input = result;
    output = result;
    oldInput = '';
    isResultDisplayed = true;
    notifyListeners();
  }
}
