import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:bmi_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  TextStyle _textStyle(double fontSize, {Color color, bool isBold = true}) =>
      TextStyle(
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.w900 : FontWeight.normal,
          color: color ?? Colors.white);

  @override
  Widget build(BuildContext context) {
    final BMIBloc resultBloc = BlocProvider.of<BMIBloc>(context);
    final result = resultBloc.currentState as BMIDetails;

    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<BMIBloc>(context).dispatch(BMIHome());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Your Result',
              textAlign: TextAlign.center,
              style: _textStyle(50),
            ),
          )),
          Expanded(
            flex: 5,
            child: CustomContainer(
              color: KCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '${result.bmi.getResult()}',
                    textAlign: TextAlign.center,
                    style: _textStyle(22, color: KResultColor),
                  ),
                  Text('${result.bmi.calculateBMI()}',
                      textAlign: TextAlign.center, style: _textStyle(100)),
                  Text('Normal BMI range:\n18.5 - 25 Kg/m2',
                      textAlign: TextAlign.center, style: _textStyle(22)),
//                Text(
//                  '18.5 - 25 Kg/m2',
//                  textAlign: TextAlign.center,
//                ),
                  Text(
                    '${result.bmi.getInterpretation()}',
                    textAlign: TextAlign.center,
                    style: _textStyle(25, isBold: false),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: BottomButton(
            onPress: () {
              BlocProvider.of<BMIBloc>(context).dispatch(BMIHome());
            },
            title: 'RE-CALCULATE YOUR BMI',
          ))
        ],
      ),
    );
  }
}
