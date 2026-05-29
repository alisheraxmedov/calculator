import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get appTitle;

  /// No description provided for @improperUse.
  ///
  /// In en, this message translates to:
  /// **'Improper use!'**
  String get improperUse;

  /// No description provided for @drawerHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get drawerHistory;

  /// No description provided for @drawerLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get drawerLength;

  /// No description provided for @drawerWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get drawerWeight;

  /// No description provided for @drawerSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get drawerSquare;

  /// No description provided for @drawerTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get drawerTime;

  /// No description provided for @drawerInternet.
  ///
  /// In en, this message translates to:
  /// **'Mobile Internet'**
  String get drawerInternet;

  /// No description provided for @drawerSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get drawerSize;

  /// No description provided for @drawerSpeed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get drawerSpeed;

  /// No description provided for @drawerTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get drawerTemperature;

  /// No description provided for @drawerBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get drawerBmi;

  /// No description provided for @screenLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get screenLength;

  /// No description provided for @screenWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get screenWeight;

  /// No description provided for @screenSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get screenSquare;

  /// No description provided for @screenTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get screenTime;

  /// No description provided for @screenInternet.
  ///
  /// In en, this message translates to:
  /// **'Mobile Internet'**
  String get screenInternet;

  /// No description provided for @screenSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get screenSize;

  /// No description provided for @screenSpeed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get screenSpeed;

  /// No description provided for @screenTemperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get screenTemperature;

  /// No description provided for @screenBmi.
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index'**
  String get screenBmi;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @noHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get noHistoryYet;

  /// No description provided for @calculationsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your calculations will appear here'**
  String get calculationsAppearHere;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result: {value}'**
  String result(String value);

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistory;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all history?'**
  String get clearHistoryConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day ago} other{{count} days ago}}'**
  String daysAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour ago} other{{count} hours ago}}'**
  String hoursAgo(int count);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} minute ago} other{{count} minutes ago}}'**
  String minutesAgo(int count);

  /// No description provided for @bmiGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get bmiGender;

  /// No description provided for @bmiMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get bmiMale;

  /// No description provided for @bmiFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get bmiFemale;

  /// No description provided for @bmiHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Length (cm)'**
  String get bmiHeightLabel;

  /// No description provided for @bmiWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get bmiWeightLabel;

  /// No description provided for @bmiHeightValue.
  ///
  /// In en, this message translates to:
  /// **'{value} cm'**
  String bmiHeightValue(int value);

  /// No description provided for @bmiWeightValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String bmiWeightValue(int value);

  /// No description provided for @bmiResult.
  ///
  /// In en, this message translates to:
  /// **'BMI: {value}'**
  String bmiResult(String value);

  /// No description provided for @bmiCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category: {value}'**
  String bmiCategoryLabel(String value);

  /// No description provided for @bmiGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender: {value}'**
  String bmiGenderLabel(String value);

  /// No description provided for @bmiUnderweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiUnderweight;

  /// No description provided for @bmiNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal weight'**
  String get bmiNormal;

  /// No description provided for @bmiOverweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiOverweight;

  /// No description provided for @bmiObesity.
  ///
  /// In en, this message translates to:
  /// **'Obesity'**
  String get bmiObesity;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
