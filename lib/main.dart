import 'package:bmi_calculator/pages/home_page.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bmi_bloc.dart';
import 'bloc/gender_bloc.dart';

void main() => runApp(InputPage());

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  BMIBloc bmiBloc;
  GenderBloc genderBloc;

  @override
  void initState() {
    super.initState();
    bmiBloc = BMIBloc();
    genderBloc = GenderBloc();
  }

  @override
  void dispose() {
    bmiBloc.dispose();
    genderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<BMIBloc>(bloc: bmiBloc),
          BlocProvider<GenderBloc>(bloc: genderBloc),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              accentColor: KAccentColor,
              primaryColor: KPrimaryColor,
              scaffoldBackgroundColor: KScaffoldBackgroundColor,
              textTheme: TextTheme(body1: TextStyle(color: KTitleColor))),
          home: HomPage(),
        ));
  }
}
