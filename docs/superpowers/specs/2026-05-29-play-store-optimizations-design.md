# Play Store Optimizatsiyalar — Dizayn Spesifikatsiyasi

**Sana:** 2026-05-29  
**Maqsad:** 7 ta qolgan Play Store optimizatsiyasini ikki parallel batch'da amalga oshirish.

---

## Umumiy yondashuv

Ishlar ikki mustaqil batch'ga bo'linadi. Batch 1 faqat Android konfiguratsiya fayllari (Gradle/XML/Manifest), Batch 2 faqat Flutter/Dart kodi. Ular bir-biriga bog'liq emas — parallel ishlanadi.

---

## Batch 1: Android Konfiguratsiya

### 1.1 Bundle Split + ABI Filters (`android/app/build.gradle`)

`android {}` blokiga qo'shiladi:

```gradle
bundle {
  density  { enableSplit = true }
  abi      { enableSplit = true }
  language { enableSplit = true }
}
```

`defaultConfig {}` blokiga qo'shiladi:

```gradle
resourceConfigurations += ['en', 'uz', 'ru']
ndk {
  abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86_64'
}
```

**Natija:** Play Store foydalanuvchi qurilmasiga mos ABI/density/language split beradi — ~30% kichikroq download.

---

### 1.2 Per-App Language (`res/xml/locales_config.xml` — yangi fayl)

```xml
<?xml version="1.0" encoding="utf-8"?>
<locale-config xmlns:android="http://schemas.android.com/apk/res/android">
    <locale android:name="en"/>
    <locale android:name="uz"/>
    <locale android:name="ru"/>
</locale-config>
```

`AndroidManifest.xml` `<application>` tag'iga:
```xml
android:localeConfig="@xml/locales_config"
```

**Natija:** Android 13+ da foydalanuvchi Settings → Apps → Calculator → Language'dan til tanlay oladi.

---

### 1.3 Backup Rules (`res/xml/backup_rules.xml` va `res/xml/data_extraction_rules.xml` — yangi fayllar)

`backup_rules.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<full-backup-content>
    <include domain="sharedpref" path="GetStorage.xml"/>
</full-backup-content>
```

`data_extraction_rules.xml`:
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

`AndroidManifest.xml` `<application>` tag'iga:
```xml
android:fullBackupContent="@xml/backup_rules"
android:dataExtractionRules="@xml/data_extraction_rules"
```

**Natija:** Foydalanuvchi history va settings'i Google Drive'ga backup bo'ladi, qurilma o'zgartirishda saqlanadi.

---

## Batch 2: Flutter Kodi

### 2.1 Semantics — Accessibility (`lib/widgets/button.dart`, `lib/screens/bmi_screen.dart`, `lib/screens/one.dart`)

**button.dart** — `GestureDetector` `Semantics` bilan o'raladi:
```dart
Semantics(
  button: true,
  label: widget.text,
  child: GestureDetector(...),
)
```

**bmi_screen.dart** — ikkala `Slider`'ga `semanticFormatterCallback` qo'shiladi:
- Height slider: `semanticFormatterCallback: (v) => '${v.round()} santimetr'`
- Weight slider: `semanticFormatterCallback: (v) => '${v.round()} kilogramm'`

**one.dart** — kalkulyator output `Text`'i `Semantics` bilan o'raladi:
```dart
Semantics(
  liveRegion: true,
  label: 'Natija: $output',
  child: Text(output, ...),
)
```

**Natija:** Play Store Accessibility Scanner ball oshadi, TalkBack foydalanuvchilari buttonlarni, slider qiymatlarini va natijani eshitadi.

---

### 2.2 Deep Link Handler (`pubspec.yaml` + `lib/screens/calculator.dart`)

**pubspec.yaml** `dependencies`'ga:
```yaml
app_links: ^6.3.5
```

**`CalculatorScreen`** `StatelessWidget`'dan `StatefulWidget`'ga o'tkaziladi. `initState`'da **ikki holat** handle qilinadi:

```dart
void _handleLink(Uri uri) {
  switch (uri.host) {
    case 'length':   Navigator.push(context, MaterialPageRoute(builder: (_) => const LengthScreen()));
    case 'weight':   Navigator.push(context, MaterialPageRoute(builder: (_) => const WeightScreen()));
    case 'history':  Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
  }
}

@override
void initState() {
  super.initState();
  // 1. Cold start: shortcut tap → app yangi ochiladi — initial link orqali keladi
  AppLinks().getInitialLink().then((uri) {
    if (uri != null) _handleLink(uri);
  });
  // 2. Warm start: app background'da — stream orqali keladi
  _linkSub = AppLinks().uriLinkStream.listen(_handleLink);
}
```

`MaterialPageRoute` ishlatiladi — `_smoothPushRoute` drawer.dart'da private funksiya (import qilib bo'lmaydi). Shortcut'dan cold start'da animatsiya ko'rinmaydi, farqi yo'q.

`dispose()`'da `_linkSub.cancel()` chaqiriladi.

**Natija:** Long-press app icon → "Length" shortcut'i tap qilinganda to'g'ridan-to'g'ri `LengthScreen` ochiladi.

---

### 2.3 GitHub Actions CI (`.github/workflows/ci.yaml` — yangi fayl)

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
      - run: flutter test test/unit/
      - run: flutter build appbundle --debug --tree-shake-icons
```

Faqat `test/unit/` papkasi ishga tushiriladi — `test/widget_test.dart` (hozirgi default broken test) CI'dan chiqarib qo'yiladi.

**Natija:** Har commit'da analyze + unit test + build avtomatik tekshiriladi.

---

### 2.4 Unit Testlar (`test/unit/` — yangi papka va 3 fayl)

**pubspec.yaml** `dev_dependencies`'ga:
```yaml
mockito: ^5.4.4
build_runner: ^2.4.13
```

**`test/unit/length_provider_test.dart`** — LengthProvider testlari:
- `convert(1.0, 'Meter m', 'Centimeter cm')` → `100.0`
- `convert(1.0, 'Kilometer km', 'Meter m')` → `1000.0`
- `convert(1.0, 'Foot ft', 'Meter m')` → `~0.3048`
- noma'lum unit → `ArgumentError` throwsArgumentError

**`test/unit/weight_provider_test.dart`** — WeightProvider testlari:
- `convert(1.0, 'Kilogram kg', 'Gram g')` → `1000.0`
- `convert(1000.0, 'Milligram mg', 'Gram g')` → `1.0`
- `convert(1.0, 'Ton t', 'Kilogram kg')` → `1000.0`
- noma'lum unit → `ArgumentError`

**`test/unit/bmi_provider_test.dart`** — BMIProvider testlari:
- Mos height/weight bilan BMI hisoblash to'g'riligi
- category: 17.0 BMI → `underweight`, 22.0 → `normal`, 27.0 → `overweight`, 35.0 → `obesity`
- `updateHeight`/`updateWeight` chaqirilganda BMI qayta hisoblanishi

---

## Fayllar ro'yxati (jami 14 ta)

| Fayl | O'zgartirish turi |
|---|---|
| `android/app/build.gradle` | Yangilanadi |
| `android/app/src/main/res/xml/locales_config.xml` | Yangi |
| `android/app/src/main/res/xml/backup_rules.xml` | Yangi |
| `android/app/src/main/res/xml/data_extraction_rules.xml` | Yangi |
| `android/app/src/main/AndroidManifest.xml` | Yangilanadi |
| `lib/widgets/button.dart` | Yangilanadi |
| `lib/screens/bmi_screen.dart` | Yangilanadi |
| `lib/screens/one.dart` | Yangilanadi |
| `lib/screens/calculator.dart` | Yangilanadi (StatefulWidget) |
| `pubspec.yaml` | Yangilanadi |
| `.github/workflows/ci.yaml` | Yangi |
| `test/unit/length_provider_test.dart` | Yangi |
| `test/unit/weight_provider_test.dart` | Yangi |
| `test/unit/bmi_provider_test.dart` | Yangi |

---

## Muvaffaqiyat mezoni

- `flutter analyze` — 0 xato
- `flutter test test/unit/` — barcha testlar o'tadi
- `flutter build appbundle --release --tree-shake-icons` — muvaffaqiyatli build
- Long-press icon → shortcut tap → to'g'ri screen ochiladi (manual tekshiruv)
- TalkBack'da button'larni eshitish mumkin (manual tekshiruv)
