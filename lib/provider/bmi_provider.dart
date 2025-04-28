import 'package:flutter/material.dart';

class BMIProvider extends ChangeNotifier {
  double height = 170;
  double weight = 70;
  double bmi = 0;
  String category = '';
  String gender = 'Male'; // 'Erkak' yoki 'Ayol'

  void calculateBMI() {
    // Balandlikni metrga o'tkazish
    double heightInMeters = height / 100;
    // TMI formulasi: vazn / (balandlik^2)
    bmi = weight / (heightInMeters * heightInMeters);

    // TMI kategoriyasini aniqlash
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25) {
      category = 'Normal weight';
    } else if (bmi < 30) {
      category = 'Overweight';
    } else {
      category = 'Obesity';
    }

    notifyListeners();
  }

  void updateHeight(double newHeight) {
    height = newHeight;
    calculateBMI();
  }

  void updateWeight(double newWeight) {
    weight = newWeight;
    calculateBMI();
  }

  void updateGender(String newGender) {
    gender = newGender;
    notifyListeners();
  }
}
