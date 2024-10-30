// import 'package:math_expressions/math_expressions.dart';

// void main() {
//   // Matematik ifodalar
//   String percentageExpression = "200 * 0.15";
//   String squareExpression = "5^2";
//   String sqrtExpression = "sqrt(25)";
//   String sinExpression = "sin(30)";
//   String misol = "(12-2)*5 + (-40)";

//   Parser parser = Parser();
//   ContextModel contextModel = ContextModel();

//   double percentageResult = parser
//       .parse(percentageExpression)
//       .evaluate(EvaluationType.REAL, contextModel);
//   double squareResult = parser
//       .parse(squareExpression)
//       .evaluate(EvaluationType.REAL, contextModel);
//   double sqrtResult =
//       parser.parse(sqrtExpression).evaluate(EvaluationType.REAL, contextModel);
//   double sinResult =
//       parser.parse(sinExpression).evaluate(EvaluationType.REAL, contextModel);
//   double misolResult =
//       parser.parse(misol).evaluate(EvaluationType.REAL, contextModel);

//   print("Foiz: $percentageResult"); // 200 ning 15 foizi
//   print("Kvadrat: $squareResult"); // 5 ning kvadrati
//   print("Kvadrat ildiz: $sqrtResult"); // 25 ning kvadrat ildizi
//   print("Sinus: $sinResult"); // 30 gradus sinus
//   print("Misol Javobi: $misolResult"); // 30 gradus sinus
// }
