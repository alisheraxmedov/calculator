import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class ProviderClass extends ChangeNotifier {
  String output = '';
  String action = '';
  String output1 = '';
  String input = '';
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  void buttonPressed(String btnText) {
    if (btnText == 'C') {
      input = '';
      output = '0';
      num1 = 0;
      num2 = 0;
      action = '';
      output1 = '';
      operand = '';
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == '×' ||
        btnText == '÷') {
      if (input.isNotEmpty) {
        num1 = double.parse(input);
        operand = btnText;
//=====================================================
        output1 = output;
        action = operand;
//=====================================================
        // output = input + operand;
        output = '';
        input = '';
      }
    } else if (btnText == '=') {
      if (input.isNotEmpty && operand.isNotEmpty) {
        num2 = double.parse(input);
        switch (operand) {
          case '+':
            output = (num1 + num2).toString();
            break;
          case '-':
            output = (num1 - num2).toString();
            break;
          case '×':
            output = (num1 * num2).toString();
            break;
          case '÷':
            output = (num1 / num2).toString();
            break;
        }
        output1 = output; // Yangi hisoblash uchun natijani saqlash
        operand = '';
        action = '';
        // output = '';
      }
    } else {
      input += btnText; // Raqamlarni inputga qo'shish
      output = output == '0'
          ? btnText
          : output + btnText; // Raqamlarni outputga qo'shish
    }
    notifyListeners();
  }
//==================================================================
//==================================================================
//==================================================================

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  String result = '';
  void solveResult(String buttonText) {
    if (buttonText == "C") {
      result = '';
    } else if (buttonText == '=') {
      // Parser obyektini yaratish
      Parser parser = Parser();

      // Ifodani analiz qilish
      Expression expression = parser.parse(result);

      // Kontekst yaratish (ixtiyoriy)
      ContextModel contextModel = ContextModel();

      // Ifodani baholash
      result = expression.evaluate(EvaluationType.REAL, contextModel);
    }
    result += buttonText;
    notifyListeners();
  }
}
