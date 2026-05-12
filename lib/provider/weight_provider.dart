import 'package:calculator/provider/base_converter_provider.dart';

class WeightProvider extends BaseConverterProvider {
  WeightProvider()
      : super(
          input: '1',
          output: '1000',
          fromUnit: 'Kilogram kg',
          toUnit: 'Gram g',
        );

  @override
  final List<String> units = const [
    'Milligram mg',
    'Gram g',
    'Kilogram kg',
    'Ton t',
  ];

  // Birliklarning grammga nisbatan koeffitsiyentlari.
  static const Map<String, double> _factors = {
    'Milligram mg': 1000.0,
    'Gram g': 1.0,
    'Kilogram kg': 0.001,
    'Ton t': 0.000001,
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
