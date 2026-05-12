import 'package:calculator/provider/base_converter_provider.dart';

class AreaProvider extends BaseConverterProvider {
  AreaProvider()
      : super(
          input: '1',
          output: '0.000001',
          fromUnit: 'Square meter m²',
          toUnit: 'Square kilometer km²',
        );

  @override
  final List<String> units = const [
    'Square meter m²',
    'Square kilometer km²',
    'Square centimeter cm²',
    'Square millimeter mm²',
    'Hectare ha',
  ];

  // Birliklarning kvadrat metrga nisbatan koeffitsiyentlari.
  static const Map<String, double> _factors = {
    'Square meter m²': 1.0,
    'Square kilometer km²': 0.000001,
    'Square centimeter cm²': 10000.0,
    'Square millimeter mm²': 1000000.0,
    'Hectare ha': 0.0001,
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
