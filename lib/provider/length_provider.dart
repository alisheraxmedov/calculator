import 'package:calculator/provider/base_converter_provider.dart';

class LengthProvider extends BaseConverterProvider {
  LengthProvider()
      : super(
          input: '1',
          output: '100',
          fromUnit: 'Meter m',
          toUnit: 'Centimeter cm',
        );

  @override
  final List<String> units = const [
    'Meter m',
    'Centimeter cm',
    'Millimeter mm',
    'Kilometer km',
    'Inches in',
    'Foot ft',
    'Yard yd',
  ];

  // Birliklarning metrga nisbatan koeffitsiyentlari.
  static const Map<String, double> _factors = {
    'Meter m': 1.0,
    'Centimeter cm': 100.0,
    'Millimeter mm': 1000.0,
    'Kilometer km': 0.001,
    'Inches in': 39.3701,
    'Foot ft': 3.28084,
    'Yard yd': 1.09361,
  };

  @override
  double convert(double value, String from, String to) {
    final fromFactor = _factors[from];
    final toFactor = _factors[to];
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Unknown unit: $from → $to');
    }
    return value / fromFactor * toFactor;
  }
}
