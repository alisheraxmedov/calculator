/*
Keyinchalik:mana shu qismlarni ham qo'shish kerak
{'icon': Icons.currency_exchange, 'title': 'Valyuta'},
{'icon': Icons.local_offer, 'title': 'Chegirma'},
{'icon': Icons.qr_code, 'title': 'Raqamli tizim'},
 */

import 'package:calculator/consts/colors.dart';

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

class DrawerWidget extends StatelessWidget {
  final double width;
  const DrawerWidget({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> drawerItems = [
      {'icon': Icons.history, 'title': 'History'},
      {'icon': Icons.straighten, 'title': 'Length'},
      {'icon': Icons.monitor_weight, 'title': 'Weight'},
      {'icon': Icons.crop_square, 'title': 'Square'},
      {'icon': Icons.access_time, 'title': 'Time'},
      {'icon': Icons.wifi, 'title': 'Mobile Internet'},
      {'icon': Icons.inbox, 'title': 'Size'},
      {'icon': Icons.speed, 'title': 'Speed'},
      {'icon': Icons.thermostat, 'title': 'Temperature'},
      {'icon': Icons.data_usage, 'title': 'BMI'},
    ];
    return Drawer(
      width: width * 0.8,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
                      color: ColorClass.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.calculate,
                      size: width * 0.12,
                      color: ColorClass.white,
                    ),
                  ),
                  SizedBox(height: width * 0.018),
                  Text(
                    'Calculator',
                    style: TextStyle(
                      color: ColorClass.white,
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: width * 0.01),
                  Text(
                    'Unit Converter',
                    style: TextStyle(
                      color: ColorClass.white.withOpacity(0.8),
                      fontSize: width * 0.04,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...drawerItems.map((item) {
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(width * 0.02),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    child: Icon(
                      item['icon'],
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Widget screen;
                    switch (item['title']) {
                      case 'History':
                        screen = const HistoryScreen();
                        break;
                      case 'Lenth':
                        screen = const LengthScreen();
                        break;
                      case 'Weight':
                        screen = const WeightScreen();
                        break;
                      case 'Square':
                        screen = const AreaScreen();
                        break;
                      case 'Time':
                        screen = const TimeScreen();
                        break;
                      case 'Mobile Internet':
                        screen = const InternetScreen();
                        break;
                      case 'Size':
                        screen = const VolumeScreen();
                        break;
                      case 'Speed':
                        screen = const SpeedScreen();
                        break;
                      case 'Temperature':
                        screen = const TemperatureScreen();
                        break;
                      case 'BMI':
                        screen = const BMIScreen();
                        break;
                      default:
                        screen = const LengthScreen();
                    }
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => screen,
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(
                            CurveTween(curve: curve),
                          );

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  hoverColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                  ),
                ),
                if (drawerItems.indexOf(item) != drawerItems.length - 1)
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
