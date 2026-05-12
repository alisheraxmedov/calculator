import 'package:calculator/provider/base_converter_provider.dart';

class SpeedProvider extends BaseConverterProvider {
  SpeedProvider()
      : super(
          input: '1',
          output: '3.6',
          fromUnit: 'Meter/second m/s',
          toUnit: 'Kilometre/hour km/h',
        );

  @override
  final List<String> units = const [
    'Meter/second m/s',
    'Kilometre/hour km/h',
    'Mile/hour mph',
    'Foot/second ft/s',
  ];

  // Birliklarning metr/sekundga nisbatan koeffitsiyentlari.
  static const Map<String, double> _factors = {
    'Meter/second m/s': 1.0,
    'Kilometre/hour km/h': 3.6,
    'Mile/hour mph': 2.23694,
    'Foot/second ft/s': 3.28084,
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
