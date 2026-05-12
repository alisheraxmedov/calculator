import 'package:calculator/provider/base_converter_provider.dart';

class TimeProvider extends BaseConverterProvider {
  TimeProvider()
      : super(
          input: '60',
          output: '1',
          fromUnit: 'Second s',
          toUnit: 'Minute min',
        );

  @override
  final List<String> units = const [
    'Millisecond ms',
    'Second s',
    'Minute min',
    'Hour h',
    'Day',
    'Week',
    'Month',
    'Year',
  ];

  // Har bir birlikning sekundlardagi qiymati (Month/Year — o'rtacha Gregorian).
  static const Map<String, double> _secondsPerUnit = {
    'Millisecond ms': 0.001,
    'Second s': 1.0,
    'Minute min': 60.0,
    'Hour h': 3600.0,
    'Day': 86400.0,
    'Week': 604800.0,
    'Month': 2629746.0,
    'Year': 31556952.0,
  };

  @override
  double convert(double value, String from, String to) {
    final fromSec = _secondsPerUnit[from];
    final toSec = _secondsPerUnit[to];
    if (fromSec == null || toSec == null) {
      throw ArgumentError('Unknown unit: $from → $to');
    }
    return value * fromSec / toSec;
  }
}
