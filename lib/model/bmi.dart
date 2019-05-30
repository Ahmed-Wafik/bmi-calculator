import 'dart:math';

import 'package:bmi_calculator/model/gender.dart';

class BMI {
  Type gender;
  int height;
  int weight;
  int age;
  double _result;

  BMI(
      {this.gender = Type.male,
      this.height = 100,
      this.weight = 60,
      this.age = 25});

  String calculateBMI() {
    _result = weight / pow(height / 100.0, 2);
    return _result.toStringAsFixed(1);
  }

  String getResult() {
    calculateBMI();
    if (_result >= 25) {
      return 'Overweight';
    } else if (_result > 18) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_result >= 25) {
      return 'You are a higher than a normal weight. Try to exercise more.';
    } else if (_result > 18) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. Toy can eat a bit more';
    }
  }

  @override
  String toString() =>
      'Gender: ${gender.toString().substring(5)} Height: $height Weight: $weight Age: $age';
}
