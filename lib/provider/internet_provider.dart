import 'package:calculator/provider/base_converter_provider.dart';

class InternetProvider extends BaseConverterProvider {
  InternetProvider()
      : super(
          input: '1',
          output: '0.001',
          fromUnit: 'Megabyte MB',
          toUnit: 'Gigabyte GB',
        );

  @override
  final List<String> units = const [
    'Bit b',
    'Byte B',
    'Kilobyte KB',
    'Megabyte MB',
    'Gigabyte GB',
    'Terabyte TB',
  ];

  // Birliklarning baytga nisbatan koeffitsiyentlari.
  static const Map<String, double> _factors = {
    'Bit b': 8.0,
    'Byte B': 1.0,
    'Kilobyte KB': 1 / 1024,
    'Megabyte MB': 1 / (1024 * 1024),
    'Gigabyte GB': 1 / (1024 * 1024 * 1024),
    'Terabyte TB': 1 / (1024 * 1024 * 1024 * 1024),
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
