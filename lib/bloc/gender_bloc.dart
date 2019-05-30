import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/model/gender.dart';

class ChangeGender {
  Type gender;

  ChangeGender(this.gender);
}

class GenderState {
  bool maleSelected = true;
  bool femaleSelected = false;

  GenderState({this.femaleSelected, this.maleSelected});
}

class GenderBloc extends Bloc<ChangeGender, GenderState> {
  bool maleSelected = true;
  bool femaleSelected = false;

  @override
  GenderState get initialState =>
      GenderState(maleSelected: true, femaleSelected: false);

  @override
  Stream<GenderState> mapEventToState(ChangeGender event) async* {
    if (event is ChangeGender) {
      bool male = currentState.maleSelected;
      bool female = currentState.femaleSelected;
      if ((event.gender == Type.male && male) ||
          (event.gender == Type.female && female)) return;
      yield GenderState(maleSelected: !male, femaleSelected: !female);
    }
  }
}
