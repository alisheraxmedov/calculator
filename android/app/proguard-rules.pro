# Flutter umumiy ProGuard qoidalari.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Yangi ishlatilmayotgan API ogohlantirishlarini o'chirish.
-dontwarn io.flutter.embedding.**
