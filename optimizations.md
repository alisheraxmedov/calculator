# Play Store Optimizatsiya Qo'llanmasi

Calculator loyihasi uchun Play Store'da yuqori ranking olish va organic install'larni oshirish bo'yicha to'liq texnik reja.

> Play Store ranking algoritmi 3 ta asosiy yo'nalishga asoslanadi:
> 1. **App Quality Signals** (Play Vitals — texnik ko'rsatkichlar)
> 2. **User Engagement** (install velocity, retention, rating)
> 3. **ASO** (Play Console listing — title, keywords, screenshots)
>
> Bu hujjat **texnik tomon** (1 va qisman 2)ga qaratilgan.

---

## 1. Build va APK hajmi — Eng katta ta'sir

### Allaqachon qilingan ✅

- R8 minify (`minifyEnabled = true`)
- `shrinkResources = true`
- ProGuard rules (`android/app/proguard-rules.pro`)
- `targetSdk = 35` (eng so'nggi)
- `minSdk = 24`
- Java 17
- Release build signing config

### Qo'shish kerak

#### 1.1 Bundle split + resource configs

**`android/app/build.gradle`** ga:

```gradle
android {
    bundle {
        density { enableSplit = true }
        abi { enableSplit = true }
        language { enableSplit = true }
    }

    defaultConfig {
        // Faqat kerakli til resurslari kirsin
        resourceConfigurations += ['en', 'uz', 'ru']
        // ABI bo'yicha alohida APK
        ndk {
            abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
        }
    }
}
```

#### 1.2 AAB (Android App Bundle) bilan build qilish

APK o'rniga AAB yuklang — Play Store foydalanuvchining qurilmasiga moslab ABI/density/language split qiladi, **~30% kichikroq** download:

```bash
flutter build appbundle --release \
    --tree-shake-icons \
    --split-debug-info=symbols \
    --obfuscate
```

| Flag | Foyda |
|---|---|
| `--tree-shake-icons` | Material Icons'dan ishlatilmaganini olib tashlaydi (10-20MB tejov) |
| `--split-debug-info=symbols` | Debug ramz ma'lumotlarini ajratadi (Crashlytics uchun saqlang) |
| `--obfuscate` | Dart kod obfuskatsiya qilinadi, reverse-engineering qiyinlashadi |

#### 1.3 Asset optimizatsiyasi

- PNG → **WebP** ga o'tkazing (30-50% kichikroq)
- Ishlatilmagan asset'larni o'chiring
- SVG icon'lar uchun `flutter_svg` — vector siqilgan
- Splash screen image'ini kichik o'lchamga moslang

---

## 2. Cold Start (Play Vitals'ning eng muhim metrikasi)

> Google "**slow startup**" ko'rsatkichi **5% dan oshsa** ranking pasayadi.
> Cold start 5 sekunddan oshsa "slow" deb belgilanadi.

### 2.1 main.dart'da bloklovchi operatsiyalarni kamaytirish

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Splash darhol ko'rsat, kritik bo'lmagan ishni keyinga qoldir
  await GetStorage.init();

  runApp(const MyApp());

  // Cold start'dan keyin keyingi ishlar
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Lazy ishlar shu yerda: analytics init, prefetch, h.k.
  });
}
```

### 2.2 Native splash screen

`flutter_native_splash` paketi Android 12+ ning native Splash Screen API'siga moslashadi:

```yaml
dev_dependencies:
  flutter_native_splash: ^2.4.1

flutter_native_splash:
  color: "#000000"
  color_dark: "#000000"
  image: assets/icon.png
  android_12:
    image: assets/icon.png
    color: "#000000"
    icon_background_color: "#000000"
```

```bash
dart run flutter_native_splash:create
```

Cold start ~300-500ms tezroq tuyiladi (Flutter engine yuklanayotgan vaqtda foydalanuvchi oq ekran o'rniga icon ko'radi).

### 2.3 Provider lazy init

Hozir `HistoryProvider()` constructor'da `_loadHistory()` chaqiradi (sync, lekin storage o'qish). Buni microtask'ga ko'chirish mumkin:

```dart
HistoryProvider() {
  Future.microtask(_loadHistory);
}
```

Lekin bu UI bo'sh holatda chiqmasligi uchun ehtiyot bo'ling. Hozirgi yondashuv ham qabul qilinadigan.

---

## 3. Crash-free Rate — 99%+ bo'lishi shart

> Play Vitals'da crash rate **1.09% dan oshsa** "bad performance" deb belgilanadi va ranking pasayadi.

### 3.1 Firebase Crashlytics qo'shish

```yaml
dependencies:
  firebase_core: ^3.6.0
  firebase_crashlytics: ^4.1.3
```

```bash
flutterfire configure
```

```dart
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Flutter framework xatolari
  FlutterError.onError =
      FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Platform/Dart async xatolari
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await GetStorage.init();
  runApp(const MyApp());
}
```

### 3.2 Symbol upload (release build)

Obfuscated build uchun crash stack trace'lar foydasiz, symbol'larni yuklang:

```bash
firebase crashlytics:symbols:upload --app=APP_ID symbols/
```

---

## 4. Adaptive Icon — Brand quality + qidiruvda ko'rinish

> Play Store qidiruvida **icon** eng muhim ko'rinish elementi. Adaptive Icon "modern app" signali beradi.

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"
  adaptive_icon_background: "#000000"
  adaptive_icon_foreground: "assets/icon_foreground.png"
  min_sdk_android: 24
  remove_alpha_ios: true
  windows:
    generate: true
  macos:
    generate: true
```

```bash
dart run flutter_launcher_icons
```

Adaptive icon Android 8+ ning round/squircle/teardrop shakllariga **avtomatik moslashadi**. Icon foreground 1080x1080 PNG, foydalanuvchi shape'iga qarab tahrirlanadi.

---

## 5. Lokalizatsiya — Yangi bozorlar = Yangi ranking

> Bitta app uchun **uz, ru, en** localization → O'zbekiston/Rossiya/inglizcha qidiruvlarida birinchi 10 ga chiqish ehtimoli sezilarli oshadi.
> Play Store'da har til alohida ranking algoritmi.

### 5.1 Flutter localization sozlash

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

flutter:
  generate: true
```

Loyiha root'ida `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

`lib/l10n/app_en.arb`:

```json
{
  "@@locale": "en",
  "appTitle": "Calculator",
  "length": "Length",
  "weight": "Weight",
  "history": "History",
  "noHistoryYet": "No history yet",
  "improperUse": "Improper use!"
}
```

`lib/l10n/app_uz.arb`:

```json
{
  "@@locale": "uz",
  "appTitle": "Kalkulyator",
  "length": "Uzunlik",
  "weight": "Og'irlik",
  "history": "Tarix",
  "noHistoryYet": "Hozircha tarix yo'q",
  "improperUse": "Noto'g'ri kiritildi!"
}
```

`lib/l10n/app_ru.arb`:

```json
{
  "@@locale": "ru",
  "appTitle": "Калькулятор",
  "length": "Длина",
  "weight": "Вес",
  "history": "История",
  "noHistoryYet": "История пуста",
  "improperUse": "Неверный ввод!"
}
```

### 5.2 MyApp'da supportedLocales

```dart
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  ...
)
```

### 5.3 Play Console'da

Store Listing → **Manage translations** → uz/ru qo'shing:
- Title (har til uchun)
- Short description (80 belgi)
- Full description (4000 belgi)
- Screenshot (har til uchun alohida)

Play Store organicheskii install **+30-50%** berishi mumkin.

---

## 6. Modern Android xususiyatlari

> targetSdk = 35 tanlanganda quyidagi feature'lar Google tomonidan **kutiladi**.

### 6.1 Predictive back gesture (Android 13+)

`android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:enableOnBackInvokedCallback="true"
    ...>
```

### 6.2 Per-app language preference (Android 13+)

`android/app/src/main/res/xml/locales_config.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<locale-config xmlns:android="http://schemas.android.com/apk/res/android">
    <locale android:name="en"/>
    <locale android:name="uz"/>
    <locale android:name="ru"/>
</locale-config>
```

Manifest'ga:

```xml
<application>
    <meta-data
        android:name="android.app.locales"
        android:resource="@xml/locales_config" />
</application>
```

Foydalanuvchi Settings → Apps → Calculator → Language ni alohida tanlay oladi.

### 6.3 Backup rules

Foydalanuvchi history'sini Google Drive'ga avtomatik backup → user retention oshadi.

`android/app/src/main/res/xml/backup_rules.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<full-backup-content>
    <include domain="sharedpref" path="GetStorage.xml"/>
</full-backup-content>
```

`android/app/src/main/res/xml/data_extraction_rules.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<data-extraction-rules>
    <cloud-backup>
        <include domain="sharedpref" path="."/>
    </cloud-backup>
    <device-transfer>
        <include domain="sharedpref" path="."/>
    </device-transfer>
</data-extraction-rules>
```

Manifest'da:

```xml
<application
    android:dataExtractionRules="@xml/data_extraction_rules"
    android:fullBackupContent="@xml/backup_rules"
    ...>
```

---

## 7. Accessibility — Rating signal

> Google "Accessibility scanner" loyihalarni ball beradi.
> TalkBack foydalanuvchilari va 50+ yoshlilar uchun katta ahamiyat.

### 7.1 ButtonWidget'ga Semantics

```dart
return Semantics(
  button: true,
  label: widget.text,
  child: GestureDetector(...),
);
```

### 7.2 Slider (BMI)

```dart
Slider(
  value: provider.height,
  semanticFormatterCallback: (value) => '${value.round()} santimetr',
  ...
)
```

### 7.3 Display matnlari

Kalkulyator natijasi ekranida:

```dart
Semantics(
  liveRegion: true, // o'zgarishi e'lon qilinadi
  label: 'Result: $output',
  child: Text(output, ...),
)
```

### 7.4 Kontrast

Min `4.5:1` matn/fon kontrasti talab qilinadi. Hozirgi orange'ning oq fonda kontrasti `2.1:1` — past. Quyuqroq orange variant ishlatish kerak.

---

## 8. App Shortcuts — Play Store badge

> Long-press app icon menyusi orqali Play Store "**Quick actions**" badge'ini ko'rsatadi → CTR oshadi.

`android/app/src/main/res/xml/shortcuts.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<shortcuts xmlns:android="http://schemas.android.com/apk/res/android">
    <shortcut
        android:shortcutId="length"
        android:enabled="true"
        android:icon="@drawable/ic_length"
        android:shortcutShortLabel="@string/shortcut_length"
        android:shortcutLongLabel="@string/shortcut_length_long">
        <intent
            android:action="android.intent.action.VIEW"
            android:targetPackage="com.alisher.calculator"
            android:targetClass="com.alisher.calculator.MainActivity"
            android:data="calculator://length" />
    </shortcut>

    <shortcut
        android:shortcutId="weight"
        android:enabled="true"
        android:icon="@drawable/ic_weight"
        android:shortcutShortLabel="@string/shortcut_weight">
        <intent android:action="android.intent.action.VIEW"
            android:targetPackage="com.alisher.calculator"
            android:targetClass="com.alisher.calculator.MainActivity"
            android:data="calculator://weight" />
    </shortcut>

    <shortcut
        android:shortcutId="history"
        android:enabled="true"
        android:icon="@drawable/ic_history"
        android:shortcutShortLabel="@string/shortcut_history">
        <intent android:action="android.intent.action.VIEW"
            android:targetPackage="com.alisher.calculator"
            android:targetClass="com.alisher.calculator.MainActivity"
            android:data="calculator://history" />
    </shortcut>
</shortcuts>
```

Manifest'da:

```xml
<activity ...>
    <intent-filter>...</intent-filter>
    <meta-data
        android:name="android.app.shortcuts"
        android:resource="@xml/shortcuts" />
</activity>
```

Flutter tomonida `uni_links` yoki `app_links` paketi orqali deep link'ni qabul qilib, kerakli screen'ga navigate qilish.

---

## 9. Privacy & Data Safety

> Play Store **Data Safety Form** to'ldirilmasa, app **suspended** bo'lishi mumkin.

### 9.1 Privacy Policy URL

Eng oddiy: GitHub Pages'da bitta HTML fayl.

`docs/privacy.html`:

```html
<!DOCTYPE html>
<html>
<head><title>Calculator Privacy Policy</title></head>
<body>
<h1>Privacy Policy</h1>
<p>Calculator app does not collect any personal data. All calculations and
history are stored locally on your device.</p>
<p>If Firebase Crashlytics is enabled, anonymous crash reports may be
sent to help us improve the app. No personal information is included.</p>
<p>Contact: alisherakhmedov.aidev@gmail.com</p>
</body>
</html>
```

GitHub repo'da Settings → Pages → main branch /docs folder → URL hosil bo'ladi.

### 9.2 Play Console → App content

- **Privacy policy**: URL'ni kiriting
- **Data safety**: Crashlytics qo'shsangiz "Anonymous crash data" deb belgilang. Aks holda "No data collected".
- **App access**: Login talab qilmasligi — belgilang
- **Ads**: Yo'q — belgilang
- **Content rating**: Everyone (3+)
- **Target audience**: 13+ (yoshi katta)

### 9.3 Minimum permissions

Manifest'da **faqat zarurini** qoldiring:

```xml
<!-- Hozir hech qanday qo'shimcha permission KERAK EMAS (offline calc) -->
<!-- Crashlytics qo'shsangiz quyidagilar avtomatik qo'shiladi: -->
<!-- <uses-permission android:name="android.permission.INTERNET"/> -->
<!-- <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/> -->
```

INTERNET permission'ni Data Safety formada e'lon qilish kerak.

---

## 10. Performance Monitoring

### 10.1 Firebase Performance

```yaml
dependencies:
  firebase_performance: ^0.10.0+8
```

```dart
final trace = FirebasePerformance.instance.newTrace('history_load');
await trace.start();
// loading...
await trace.stop();

// HTTP requests avtomatik kuzatiladi
// Screen rendering avtomatik kuzatiladi (frozen frames, slow frames)
```

### 10.2 Custom trace'lar

```dart
// Math evaluate vaqti
Future<void> _calculateResult(BuildContext context) async {
  final trace = FirebasePerformance.instance.newTrace('math_evaluate');
  await trace.start();
  try {
    // ... hisoblash
  } finally {
    await trace.stop();
  }
}
```

### 10.3 Play Vitals dashboard

Play Console'da avtomatik:
- ANR rate
- Crash rate
- Slow startup
- Slow rendering
- Frozen frames
- Permission denials
- Excessive wakeups
- Stuck wake locks
- Battery usage

Bularning hech biri 5% dan oshmasligi kerak.

---

## 11. User Engagement — Retention boost

> Ranking algoritmining **60-70%** ulushi foydalanuvchi xulqi.

### 11.1 In-app review (5-yulduzli rating)

```yaml
dependencies:
  in_app_review: ^2.0.10
```

```dart
import 'package:in_app_review/in_app_review.dart';

class _ReviewService {
  static const _key = 'review_request_count';
  final box = GetStorage();

  Future<void> maybeRequestReview() async {
    final count = (box.read<int>(_key) ?? 0) + 1;
    await box.write(_key, count);

    // 5-marta foydalanilgandan keyin so'rang
    if (count == 5) {
      final inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }
    }
  }
}
```

Foydalanuvchi `=` bosib natija olganidan keyin chaqiring (musbat moment).

### 11.2 Push notification (engagement)

Faqat MUHIM holatlar uchun:
- Yangi xususiyat e'lonlari
- 7 kun foydalanmagan foydalanuvchiga eslatma

```yaml
dependencies:
  firebase_messaging: ^15.1.3
```

> Spam qilmang — uninstall rate oshadi va ranking pasayadi.

### 11.3 Offline support

Hozircha hammasi offline ishlaydi (yaxshi). INTERNET kerak emasligini Play Store description'da yozing — "**Works offline**" filterda ko'rinadi.

---

## 12. Code Quality va Long-term Stability

### 12.1 Unit testlar

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.13
```

`test/converter_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/provider/length_provider.dart';

void main() {
  group('LengthProvider', () {
    test('converts meters to centimeters', () {
      final provider = LengthProvider();
      expect(provider.convert(1.0, 'Meter m', 'Centimeter cm'), 100.0);
    });

    test('converts kilometers to meters', () {
      final provider = LengthProvider();
      expect(provider.convert(1.0, 'Kilometer km', 'Meter m'), 1000.0);
    });

    test('throws on unknown unit', () {
      final provider = LengthProvider();
      expect(
        () => provider.convert(1.0, 'Unknown', 'Meter m'),
        throwsArgumentError,
      );
    });
  });
}
```

Har provider uchun shunday test. CI'da har commit'da tekshiriladi.

### 12.2 GitHub Actions CI

`.github/workflows/ci.yaml`:

```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build appbundle --release --tree-shake-icons
```

---

## 13. ASO (App Store Optimization) — Listing tomon

> Code emas, lekin natijaga bevosita ta'sir qiladi.

### 13.1 Keyword research

Maqsadli keyword'lar:
- "calculator", "scientific calculator", "unit converter", "kalkulyator", "калькулятор"
- "free calculator no ads"
- "offline calculator"

### 13.2 Title (50 belgigacha)

❌ "Calculator"
✅ "Calculator — Unit Converter & Scientific"

### 13.3 Short description (80 belgi)

✅ "Free offline calculator with unit converters: length, weight, BMI, time"

### 13.4 Full description (4000 belgi)

Keywords'ni tabiiy ravishda joylashtiring, har 100-200 belgida bitta. Birinchi 167 belgi (preview) eng muhim.

### 13.5 Screenshots

8 ta screenshot:
1. Asosiy kalkulyator (light)
2. Asosiy kalkulyator (dark)
3. Pro rejim
4. Length converter
5. Weight converter
6. BMI calculator
7. History
8. Theme switching

Har screenshot'da overlay text bilan feature ko'rsating ("Beautiful UI", "Offline", "Free").

### 13.6 Feature graphic

1024x500 banner — store top'da ko'rinadi. Aniq brand bilan.

---

## Prioritet bo'yicha amaliy reja

| # | Qadam | Ta'sir | Vaqt |
|---|---|---|---|
| 1 | AAB build + `--tree-shake-icons` + `--obfuscate` | -30% download, security | 5 daqiqa |
| 2 | Native splash screen | Cold start +500ms | 30 daqiqa |
| 3 | Adaptive icon | Brand quality | 1 soat (dizayn) |
| 4 | Crashlytics ulash | Crash-free rate ko'rsatkichi | 30 daqiqa |
| 5 | Lokalizatsiya (uz/ru/en) | +30-50% organic install | 4-8 soat |
| 6 | Privacy Policy + Data Safety | Talab — yo'q bo'lsa app suspend | 1 soat |
| 7 | Semantics + accessibility | Rating boost | 2 soat |
| 8 | App shortcuts | UX + Play Store badge | 1 soat |
| 9 | Predictive back + per-app lang | Modern Android signal | 30 daqiqa |
| 10 | Performance monitoring | Long-term optimization | 1 soat |
| 11 | In-app review prompt | Rating boost | 30 daqiqa |
| 12 | Bundle/ABI split | -30% download | 10 daqiqa |
| 13 | Unit testlar + CI | Regression prevention | 4 soat |
| 14 | ASO listing optimization | +50-200% impressions | 2 soat |

---

## Eng tezkor 5 ish (bugun qilish mumkin)

1. **AAB build** — `flutter build appbundle --release --tree-shake-icons --obfuscate --split-debug-info=symbols`
2. **`flutter_native_splash`** qo'shish — 30 daqiqa
3. **Adaptive icon** yangilash — 1 soat
4. **Crashlytics** ulash — 30 daqiqa
5. **Privacy Policy** GitHub Pages'da joylash — 30 daqiqa

Bularni qilsangiz, Play Vitals'da "Excellent" ko'rsatkichlarga chiqasiz va algoritm sizni "high quality app" deb belgilab boshqalar oldida ko'rsatadi.

---

## Foydali resurslar

- [Play Console — App Quality](https://developer.android.com/distribute/best-practices/launch/quality)
- [Play Vitals overview](https://support.google.com/googleplay/android-developer/answer/9844486)
- [Flutter performance best practices](https://docs.flutter.dev/perf/best-practices)
- [Material Design 3](https://m3.material.io/)
- [App Bundle technical docs](https://developer.android.com/guide/app-bundle)
- [Firebase Crashlytics for Flutter](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter)
- [Flutter localization codelab](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

---

## Texnik metrika maqsadlari

| Metrika | Maqsad | Hozirgi |
|---|---|---|
| Cold start | < 2s | ~? (o'lchang) |
| APK/AAB hajmi | < 15 MB | ~? (o'lchang) |
| Crash-free rate | > 99.5% | yo'q ma'lumot |
| ANR rate | < 0.47% | yo'q ma'lumot |
| Slow rendering | < 5% | yo'q ma'lumot |
| Frozen frames | < 0.1% | yo'q ma'lumot |
| Rating | > 4.3 | ? |
| Crashlytics velocity alerts | 0 | yo'q |

Bu maqsadlarga erishish uchun yuqoridagi 14 qadamni bosqichma-bosqich amalga oshiring.
