import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/model/bmi.dart';

abstract class BMIEvent {}

class BMIHome extends BMIEvent {

}

class BMIResult extends BMIEvent {
  final BMI bmi;

  BMIResult(this.bmi);

  @override
  String toString() => 'BMI calculate event is called';
}

abstract class BMIState {}

class BMIPage extends BMIState {
  BMI bmi;

  BMIPage(this.bmi);

  @override
  String toString() =>
      'BMI page state : age ${bmi.age} , weight ${bmi.weight}, height ${bmi.height}, type ${bmi.gender}';
}

class BMIDetails extends BMIState {
  final BMI bmi;
  BMIDetails({this.bmi});
  @override
  String toString() => 'BMI result page state';
}

class BMIBloc extends Bloc<BMIEvent, BMIState> {

  @override
  BMIState get initialState => BMIPage(BMI());

  @override
  Stream<BMIState> mapEventToState(BMIEvent event) async* {
    if (event is BMIResult) {

      yield BMIDetails(bmi:(currentState as BMIPage).bmi);
    }
    if (event is BMIHome) {
      yield BMIPage(BMI());
    }
  }
}
