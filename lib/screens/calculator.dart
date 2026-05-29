import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/provider.dart';
import 'package:calculator/screens/one.dart';
import 'package:calculator/widgets/drawer.dart';
import 'package:calculator/widgets/text.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            width: width,
            text: l10n.appTitle,
            fontSize: width * 0.08,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            // IconButton(
            //   tooltip: 'Firebase test',
            //   onPressed: () => _showFirebaseTestSheet(context),
            //   icon: Icon(
            //     Icons.bug_report,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            // ),
            Selector<ProviderClass, bool>(
              selector: (_, p) => p.isLight,
              builder: (context, isLight, _) => IconButton(
                onPressed: context.read<ProviderClass>().changeTheme,
                icon: Icon(
                  isLight ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        drawer: DrawerWidget(width: width),
        body: const FirstScreen(),
      ),
    );
  }

  Future<void> _showFirebaseTestSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Firebase test panel',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Firebase ulanish va xizmatlarni tekshirish'),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: const Text('1. Non-fatal error yuborish'),
              subtitle: const Text(
                  'Crashlytics ga log yuboradi (app crash bo\'lmaydi)'),
              onTap: () async {
                Navigator.pop(ctx);
                try {
                  await FirebaseCrashlytics.instance.recordError(
                    Exception('Test non-fatal error from calculator app'),
                    StackTrace.current,
                    reason: 'Manual test from Firebase test panel',
                    fatal: false,
                  );
                  await FirebaseCrashlytics.instance.log(
                      'Test log: user pressed non-fatal test button');
                  await FirebaseCrashlytics.instance.sendUnsentReports();
                  _toast(context,
                      '✅ Non-fatal yuborildi. 5-10 daqiqada Firebase Console\'da ko\'rinadi.');
                } catch (e) {
                  _toast(context, '❌ Xato: $e');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.error, color: Colors.red),
              title: const Text('2. Fatal crash test'),
              subtitle: const Text(
                  'App crash bo\'ladi! Qaytadan oching → Crashlytics\'da ko\'rinadi'),
              onTap: () {
                Navigator.pop(ctx);
                Future.delayed(const Duration(milliseconds: 300), () {
                  FirebaseCrashlytics.instance.crash();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer, color: Colors.blue),
              title: const Text('3. Performance trace yuborish'),
              subtitle: const Text(
                  'Custom trace yaratadi va Performance\'ga yuboradi'),
              onTap: () async {
                Navigator.pop(ctx);
                try {
                  final trace =
                      FirebasePerformance.instance.newTrace('manual_test_trace');
                  await trace.start();
                  await Future<void>.delayed(const Duration(seconds: 2));
                  trace.incrementMetric('test_clicks', 1);
                  await trace.stop();
                  _toast(context,
                      '✅ Trace yuborildi. Performance batch sifatida ~5-30 daqiqada yuklaydi.');
                } catch (e) {
                  _toast(context, '❌ Xato: $e');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.green),
              title: const Text('4. Build holatini ko\'rsatish'),
              subtitle: const Text(
                  'Debug yoki Release ekanini va Crashlytics holatini'),
              onTap: () async {
                Navigator.pop(ctx);
                final enabled = FirebaseCrashlytics.instance
                    .isCrashlyticsCollectionEnabled;
                final perfEnabled =
                    await FirebasePerformance.instance.isPerformanceCollectionEnabled();
                _toast(
                  context,
                  'Debug: $kDebugMode\n'
                  'Crashlytics yoqilgan: $enabled\n'
                  'Performance yoqilgan: $perfEnabled',
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.grey),
              title: const Text('5. Logcat buyrug\'i nusxalash'),
              subtitle: const Text(
                  'Telefonni USB orqali kompyuterga ulang va shu buyruqni ishlating'),
              onTap: () async {
                const cmd =
                    'adb logcat -s FirebaseCrashlytics:V FirebasePerformance:V Firebase:V';
                await Clipboard.setData(const ClipboardData(text: cmd));
                if (ctx.mounted) Navigator.pop(ctx);
                _toast(context, '📋 Buyruq nusxalandi: $cmd');
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 6),
      ),
    );
  }
}
