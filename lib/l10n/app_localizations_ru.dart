// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Калькулятор';

  @override
  String get improperUse => 'Неверный ввод!';

  @override
  String get drawerHistory => 'История';

  @override
  String get drawerLength => 'Длина';

  @override
  String get drawerWeight => 'Вес';

  @override
  String get drawerSquare => 'Площадь';

  @override
  String get drawerTime => 'Время';

  @override
  String get drawerInternet => 'Мобильный интернет';

  @override
  String get drawerSize => 'Объём';

  @override
  String get drawerSpeed => 'Скорость';

  @override
  String get drawerTemperature => 'Температура';

  @override
  String get drawerBmi => 'ИМТ';

  @override
  String get screenLength => 'Длина';

  @override
  String get screenWeight => 'Вес';

  @override
  String get screenSquare => 'Площадь';

  @override
  String get screenTime => 'Время';

  @override
  String get screenInternet => 'Мобильный интернет';

  @override
  String get screenSize => 'Объём';

  @override
  String get screenSpeed => 'Скорость';

  @override
  String get screenTemperature => 'Температура';

  @override
  String get screenBmi => 'Индекс массы тела';

  @override
  String get historyTitle => 'История';

  @override
  String get noHistoryYet => 'История пуста';

  @override
  String get calculationsAppearHere => 'Ваши вычисления появятся здесь';

  @override
  String result(String value) {
    return 'Результат: $value';
  }

  @override
  String get clearHistory => 'Очистить историю';

  @override
  String get clearHistoryConfirm =>
      'Вы уверены, что хотите очистить всю историю?';

  @override
  String get cancel => 'Отмена';

  @override
  String get clear => 'Очистить';

  @override
  String get justNow => 'Только что';

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня назад',
      many: '$count дней назад',
      few: '$count дня назад',
      one: '$count день назад',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count часа назад',
      many: '$count часов назад',
      few: '$count часа назад',
      one: '$count час назад',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count минуты назад',
      many: '$count минут назад',
      few: '$count минуты назад',
      one: '$count минута назад',
    );
    return '$_temp0';
  }

  @override
  String get bmiGender => 'Пол';

  @override
  String get bmiMale => 'Мужской';

  @override
  String get bmiFemale => 'Женский';

  @override
  String get bmiHeightLabel => 'Рост (см)';

  @override
  String get bmiWeightLabel => 'Вес (кг)';

  @override
  String bmiHeightValue(int value) {
    return '$value см';
  }

  @override
  String bmiWeightValue(int value) {
    return '$value кг';
  }

  @override
  String bmiResult(String value) {
    return 'ИМТ: $value';
  }

  @override
  String bmiCategoryLabel(String value) {
    return 'Категория: $value';
  }

  @override
  String bmiGenderLabel(String value) {
    return 'Пол: $value';
  }

  @override
  String get bmiUnderweight => 'Недостаточный вес';

  @override
  String get bmiNormal => 'Нормальный вес';

  @override
  String get bmiOverweight => 'Избыточный вес';

  @override
  String get bmiObesity => 'Ожирение';
}
