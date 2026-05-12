import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

abstract class BaseConverterProvider extends ChangeNotifier {
  static final ShuntingYardParser _parser = ShuntingYardParser();
  static final RegExp _trailingZeros = RegExp(r'([.]*0+)(?!.*\d)');

  String input;
  String output;
  String fromUnit;
  String toUnit;
  bool isResultDisplayed = false;

  BaseConverterProvider({
    required this.input,
    required this.output,
    required this.fromUnit,
    required this.toUnit,
  });

  List<String> get units;

  double convert(double value, String from, String to);

  void buttonPressed(String btnText) {
    if (btnText == 'C') {
      input = '0';
      isResultDisplayed = false;
    } else if (btnText == '⌫') {
      input = input.length > 1 ? input.substring(0, input.length - 1) : '0';
      isResultDisplayed = false;
    } else if (btnText == '=') {
      _calculateExpression();
    } else if (_isOperator(btnText)) {
      if (isResultDisplayed) {
        isResultDisplayed = false;
        input += btnText;
      } else if (input.isNotEmpty && _isOperator(input[input.length - 1])) {
        input = input.substring(0, input.length - 1) + btnText;
      } else {
        input += btnText;
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
    if (value == null || !units.contains(value)) return;
    fromUnit = value;
    _calculateExpression();
    notifyListeners();
  }

  void changeToUnit(String? value) {
    if (value == null || !units.contains(value)) return;
    toUnit = value;
    _calculateExpression();
    notifyListeners();
  }

  bool _isOperator(String s) =>
      s == '+' || s == '-' || s == '×' || s == '÷';

  void _calculateExpression() {
    try {
      final normalized = input.replaceAll('×', '*').replaceAll('÷', '/');
      final expression = _parser.parse(normalized);
      final result = (expression.evaluate(EvaluationType.REAL, ContextModel())
              as num)
          .toDouble();

      input = formatNumber(result);
      output = formatNumber(convert(result, fromUnit, toUnit));
      isResultDisplayed = true;
    } catch (_) {
      output = '0';
      input = '0';
    }
  }

  static String formatNumber(double value) {
    if (!value.isFinite) return '0';
    return value.toStringAsFixed(6).replaceAll(_trailingZeros, '');
  }
}
