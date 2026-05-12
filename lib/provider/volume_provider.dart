import 'package:calculator/provider/base_converter_provider.dart';

class VolumeProvider extends BaseConverterProvider {
  VolumeProvider()
      : super(
          input: '1',
          output: '1000',
          fromUnit: 'Cubic meter m³',
          toUnit: 'Liter l',
        );

  @override
  final List<String> units = const [
    'Cubic meter m³',
    'Liter l',
    'Milliliter ml',
    'Cubic centimeter cm³',
    'Cubic decimeter dm³',
  ];

  // Birliklarning kub metrga nisbatan koeffitsiyentlari.
  static const Map<String, double> _factors = {
    'Cubic meter m³': 1.0,
    'Liter l': 1000.0,
    'Milliliter ml': 1000000.0,
    'Cubic centimeter cm³': 1000000.0,
    'Cubic decimeter dm³': 1000.0,
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
