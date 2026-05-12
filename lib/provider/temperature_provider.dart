import 'package:calculator/provider/base_converter_provider.dart';

class TemperatureProvider extends BaseConverterProvider {
  TemperatureProvider()
      : super(
          input: '0',
          output: '32',
          fromUnit: 'Celsius °C',
          toUnit: 'Fahrenheit °F',
        );

  @override
  final List<String> units = const [
    'Celsius °C',
    'Fahrenheit °F',
    'Kelvin K',
  ];

  @override
  double convert(double value, String from, String to) {
    final celsius = switch (from) {
      'Celsius °C' => value,
      'Fahrenheit °F' => (value - 32) * 5 / 9,
      'Kelvin K' => value - 273.15,
      _ => throw ArgumentError('Unknown unit: $from'),
    };
    return switch (to) {
      'Celsius °C' => celsius,
      'Fahrenheit °F' => celsius * 9 / 5 + 32,
      'Kelvin K' => celsius + 273.15,
      _ => throw ArgumentError('Unknown unit: $to'),
    };
  }
}
