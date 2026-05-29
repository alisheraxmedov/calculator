// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Calculator';

  @override
  String get improperUse => 'Improper use!';

  @override
  String get drawerHistory => 'History';

  @override
  String get drawerLength => 'Length';

  @override
  String get drawerWeight => 'Weight';

  @override
  String get drawerSquare => 'Square';

  @override
  String get drawerTime => 'Time';

  @override
  String get drawerInternet => 'Mobile Internet';

  @override
  String get drawerSize => 'Size';

  @override
  String get drawerSpeed => 'Speed';

  @override
  String get drawerTemperature => 'Temperature';

  @override
  String get drawerBmi => 'BMI';

  @override
  String get screenLength => 'Length';

  @override
  String get screenWeight => 'Weight';

  @override
  String get screenSquare => 'Square';

  @override
  String get screenTime => 'Time';

  @override
  String get screenInternet => 'Mobile Internet';

  @override
  String get screenSize => 'Size';

  @override
  String get screenSpeed => 'Speed';

  @override
  String get screenTemperature => 'Temperature';

  @override
  String get screenBmi => 'Body Mass Index';

  @override
  String get historyTitle => 'History';

  @override
  String get noHistoryYet => 'No history yet';

  @override
  String get calculationsAppearHere => 'Your calculations will appear here';

  @override
  String result(String value) {
    return 'Result: $value';
  }

  @override
  String get clearHistory => 'Clear History';

  @override
  String get clearHistoryConfirm =>
      'Are you sure you want to clear all history?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get justNow => 'Just now';

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '$count day ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '$count hour ago',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '$count minute ago',
    );
    return '$_temp0';
  }

  @override
  String get bmiGender => 'Gender';

  @override
  String get bmiMale => 'Male';

  @override
  String get bmiFemale => 'Female';

  @override
  String get bmiHeightLabel => 'Length (cm)';

  @override
  String get bmiWeightLabel => 'Weight (kg)';

  @override
  String bmiHeightValue(int value) {
    return '$value cm';
  }

  @override
  String bmiWeightValue(int value) {
    return '$value kg';
  }

  @override
  String bmiResult(String value) {
    return 'BMI: $value';
  }

  @override
  String bmiCategoryLabel(String value) {
    return 'Category: $value';
  }

  @override
  String bmiGenderLabel(String value) {
    return 'Gender: $value';
  }

  @override
  String get bmiUnderweight => 'Underweight';

  @override
  String get bmiNormal => 'Normal weight';

  @override
  String get bmiOverweight => 'Overweight';

  @override
  String get bmiObesity => 'Obesity';
}
