// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'Kalkulyator';

  @override
  String get improperUse => 'Noto\'g\'ri kiritildi!';

  @override
  String get drawerHistory => 'Tarix';

  @override
  String get drawerLength => 'Uzunlik';

  @override
  String get drawerWeight => 'Og\'irlik';

  @override
  String get drawerSquare => 'Maydon';

  @override
  String get drawerTime => 'Vaqt';

  @override
  String get drawerInternet => 'Mobil Internet';

  @override
  String get drawerSize => 'Hajm';

  @override
  String get drawerSpeed => 'Tezlik';

  @override
  String get drawerTemperature => 'Harorat';

  @override
  String get drawerBmi => 'TVI';

  @override
  String get screenLength => 'Uzunlik';

  @override
  String get screenWeight => 'Og\'irlik';

  @override
  String get screenSquare => 'Maydon';

  @override
  String get screenTime => 'Vaqt';

  @override
  String get screenInternet => 'Mobil Internet';

  @override
  String get screenSize => 'Hajm';

  @override
  String get screenSpeed => 'Tezlik';

  @override
  String get screenTemperature => 'Harorat';

  @override
  String get screenBmi => 'Tana Vazn Indeksi';

  @override
  String get historyTitle => 'Tarix';

  @override
  String get noHistoryYet => 'Hozircha tarix yo\'q';

  @override
  String get calculationsAppearHere =>
      'Hisoblashlaringiz shu yerda paydo bo\'ladi';

  @override
  String result(String value) {
    return 'Natija: $value';
  }

  @override
  String get clearHistory => 'Tarixni tozalash';

  @override
  String get clearHistoryConfirm =>
      'Haqiqatan ham barcha tarixni tozalamoqchimisiz?';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get clear => 'Tozalash';

  @override
  String get justNow => 'Hozir';

  @override
  String daysAgo(int count) {
    return '$count kun oldin';
  }

  @override
  String hoursAgo(int count) {
    return '$count soat oldin';
  }

  @override
  String minutesAgo(int count) {
    return '$count daqiqa oldin';
  }

  @override
  String get bmiGender => 'Jins';

  @override
  String get bmiMale => 'Erkak';

  @override
  String get bmiFemale => 'Ayol';

  @override
  String get bmiHeightLabel => 'Bo\'y (sm)';

  @override
  String get bmiWeightLabel => 'Og\'irlik (kg)';

  @override
  String bmiHeightValue(int value) {
    return '$value sm';
  }

  @override
  String bmiWeightValue(int value) {
    return '$value kg';
  }

  @override
  String bmiResult(String value) {
    return 'TVI: $value';
  }

  @override
  String bmiCategoryLabel(String value) {
    return 'Kategoriya: $value';
  }

  @override
  String bmiGenderLabel(String value) {
    return 'Jins: $value';
  }

  @override
  String get bmiUnderweight => 'Vazn yetarli emas';

  @override
  String get bmiNormal => 'Normal vazn';

  @override
  String get bmiOverweight => 'Ortiqcha vazn';

  @override
  String get bmiObesity => 'Semizlik';
}
