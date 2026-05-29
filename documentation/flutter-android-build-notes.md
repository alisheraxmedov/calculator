# Flutter Android Build Notes

## Release build command (Play Store)

```bash
flutter build appbundle --release --tree-shake-icons --obfuscate --split-debug-info=symbols
```

| Flag | Nima qiladi |
|---|---|
| `--release` | Release mode build |
| `--tree-shake-icons` | Ishlatilmagan Material ikonkalarni olib tashlaydi (~99% tejov) |
| `--obfuscate` | Dart kodni obfuskatsiya qiladi (reverse-engineering qiyinlashadi) |
| `--split-debug-info=symbols` | Debug ramzlarini alohida `symbols/` papkaga chiqaradi (Crashlytics uchun kerak) |

AAB fayl manzili: `build/app/outputs/bundle/release/app-release.aab`

---

## Bilim warnings (xato emas)

### 1. Font tree-shaking

```
Font asset "MaterialIcons-Regular.otf" was tree-shaken,
reducing it from 1645184 to 3324 bytes (99.8% reduction).
```

**Muammo emas** — bu yaxshi xabar. Ishlatilmagan ikonkalar olib tashlandi.

---

### 2. DWARF debugging warning

```
Warning: The generated ELF library contains unobfuscated DWARF debugging information.
         To avoid this, use --strip to remove it.
```

**Muammo emas.** Play Store qabul qiladi, app ishlaydi.

- `--strip` Flutter CLI'da mavjud emas (Flutter toolchain xatosi)
- `--split-debug-info=symbols` debug ma'lumotlarini allaqachon ajratib qo'ygan
- Bu Flutter toolchain'ning **known warning** — fix yo'q, ignore qilish kerak
- GitHub'da ochiq issue mavjud, Flutter team tomonidan ko'rilmoqda

---

## App start time

- `1.54s` — **Excellent** (Play Vitals: < 2s = Excellent, > 5s = ranking pasayadi)

---

## google-services.json haqida

- Bitta Firebase loyihasida bir nechta app bo'lsa, barcha app'lar `client[]` array'ga tushadi
- Faqat joriy app'ning `package_name` qoldirilishi kerak, qolganlari o'chiriladi
- Analytics yoqilgandan **keyin** yangi `google-services.json` yuklab olinishi kerak

---

## Firebase Analytics ulanish tartibi

1. Firebase Console'da Analytics'ni yoqish
2. Yangi `google-services.json` yuklab olish
3. `pubspec.yaml`'ga qo'shish: `firebase_analytics: ^11.x.x`
4. `main.dart`'da: `FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode)`
