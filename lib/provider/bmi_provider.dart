import 'package:flutter/material.dart';

enum BmiCategory { underweight, normal, overweight, obesity }

enum BmiGender { male, female }

class BMIProvider extends ChangeNotifier {
  double height = 170;
  double weight = 70;
  double bmi = 0;
  BmiCategory category = BmiCategory.normal;
  BmiGender gender = BmiGender.male;

  void calculateBMI() {
    final double heightInMeters = height / 100;
    bmi = weight / (heightInMeters * heightInMeters);

    if (bmi < 18.5) {
      category = BmiCategory.underweight;
    } else if (bmi < 25) {
      category = BmiCategory.normal;
    } else if (bmi < 30) {
      category = BmiCategory.overweight;
    } else {
      category = BmiCategory.obesity;
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

  void updateGender(BmiGender newGender) {
    gender = newGender;
    notifyListeners();
  }
}
