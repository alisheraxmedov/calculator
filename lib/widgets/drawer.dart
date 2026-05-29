import 'package:calculator/consts/colors.dart';
import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/screens/area_screen.dart';
import 'package:calculator/screens/bmi_screen.dart';
import 'package:calculator/screens/history_screen.dart';
import 'package:calculator/screens/internet_screen.dart';
import 'package:calculator/screens/length_screen.dart';
import 'package:calculator/screens/speed_screen.dart';
import 'package:calculator/screens/temperature_screen.dart';
import 'package:calculator/screens/time_screen.dart';
import 'package:calculator/screens/volume_screen.dart';
import 'package:calculator/screens/weight_screen.dart';
import 'package:flutter/material.dart';

/// Yumshoq slide + fade + delicate scale o'tish — drawer'dan ochiluvchi
/// sahifalar uchun. Standart MaterialPageRoute'dan mayinroq tezlash/sekinlashish
/// va kichik parallax tuyg'usi beradi.
PageRoute<T> _smoothPushRoute<T>(WidgetBuilder builder) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, _, __) => builder(context),
    transitionDuration: const Duration(milliseconds: 480),
    reverseTransitionDuration: const Duration(milliseconds: 360),
    transitionsBuilder: (_, animation, __, child) {
      final slide = Tween<Offset>(
        begin: const Offset(0.22, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

      final scale = Tween<double>(begin: 0.96, end: 1).chain(
        CurveTween(curve: Curves.easeOutCubic),
      ).animate(animation);

      final fade = CurvedAnimation(
        parent: animation,
        curve: const Interval(0, 0.7, curve: Curves.easeOut),
        reverseCurve: const Interval(0.3, 1, curve: Curves.easeIn),
      );

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: ScaleTransition(
            scale: scale,
            child: child,
          ),
        ),
      );
    },
  );
}

class _DrawerItem {
  final IconData icon;
  final String title;
  final WidgetBuilder builder;
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.builder,
  });
}

class DrawerWidget extends StatelessWidget {
  final double width;
  const DrawerWidget({
    super.key,
    required this.width,
  });

  List<_DrawerItem> _items(AppLocalizations l10n) => [
        _DrawerItem(
          icon: Icons.history,
          title: l10n.drawerHistory,
          builder: (_) => const HistoryScreen(),
        ),
        _DrawerItem(
          icon: Icons.straighten,
          title: l10n.drawerLength,
          builder: (_) => const LengthScreen(),
        ),
        _DrawerItem(
          icon: Icons.monitor_weight,
          title: l10n.drawerWeight,
          builder: (_) => const WeightScreen(),
        ),
        _DrawerItem(
          icon: Icons.crop_square,
          title: l10n.drawerSquare,
          builder: (_) => const AreaScreen(),
        ),
        _DrawerItem(
          icon: Icons.access_time,
          title: l10n.drawerTime,
          builder: (_) => const TimeScreen(),
        ),
        _DrawerItem(
          icon: Icons.wifi,
          title: l10n.drawerInternet,
          builder: (_) => const InternetScreen(),
        ),
        _DrawerItem(
          icon: Icons.inbox,
          title: l10n.drawerSize,
          builder: (_) => const VolumeScreen(),
        ),
        _DrawerItem(
          icon: Icons.speed,
          title: l10n.drawerSpeed,
          builder: (_) => const SpeedScreen(),
        ),
        _DrawerItem(
          icon: Icons.thermostat,
          title: l10n.drawerTemperature,
          builder: (_) => const TemperatureScreen(),
        ),
        _DrawerItem(
          icon: Icons.data_usage,
          title: l10n.drawerBmi,
          builder: (_) => const BMIScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final items = _items(l10n);
    return Drawer(
      width: width * 0.8,
      backgroundColor: colorScheme.surface,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.8),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      color: ColorClass.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.calculate,
                      size: width * 0.12,
                      color: ColorClass.white,
                    ),
                  ),
                  SizedBox(height: width * 0.018),
                  Text(
                    l10n.appTitle,
                    style: TextStyle(
                      color: ColorClass.white,
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (int i = 0; i < items.length; i++) ...[
            _buildTile(context, items[i]),
            if (i != items.length - 1)
              Divider(
                height: 1,
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, _DrawerItem item) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(width * 0.02),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(width * 0.02),
        ),
        child: Icon(item.icon, color: colorScheme.primary),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push<void>(context, _smoothPushRoute(item.builder));
      },
      hoverColor: colorScheme.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.02),
      ),
    );
  }
}
