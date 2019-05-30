import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/bloc/gender_bloc.dart';
import 'package:bmi_calculator/model/gender.dart';
import 'package:bmi_calculator/bloc/counter_bloc.dart';
import 'package:bmi_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:bmi_calculator/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CounterType { weight, age }

class FirstRowWidget extends StatelessWidget {
  _onPress(Type type, BMIBloc bloc, GenderBloc genderBloc) {
    genderBloc.dispatch(ChangeGender(type));
    (bloc.currentState as BMIPage).bmi.gender = type;
  }

  @override
  Widget build(BuildContext context) {
    final BMIBloc bmiBloc = BlocProvider.of<BMIBloc>(context);
    final GenderBloc genderBloc = BlocProvider.of<GenderBloc>(context);

    return Expanded(
      child: BlocBuilder(
        bloc: genderBloc,
        builder: (BuildContext context, GenderState state) => Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => _onPress(Type.male, bmiBloc, genderBloc),
                    child: CustomContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mars,
                            size: 40,
                            color: state.maleSelected
                                ? KSelectedColor
                                : KUnSelectedColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'MALE',
                            style: TextStyle(
                                fontSize: 20,
                                color: state.maleSelected
                                    ? KSelectedColor
                                    : KUnSelectedColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => _onPress(Type.female, bmiBloc, genderBloc),
                    child: CustomContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.venus,
                            size: 40,
                            color: state.femaleSelected
                                ? KSelectedColor
                                : KUnSelectedColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'FEMALE',
                            style: TextStyle(
                                fontSize: 20,
                                color: state.femaleSelected? KSelectedColor
                                    : KUnSelectedColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

class SecondWidget extends StatefulWidget {
  const SecondWidget({Key key}) : super(key: key);

  @override
  SecondWidgetState createState() => SecondWidgetState();
}

class SecondWidgetState extends State<SecondWidget> {
  double currentValue = 100;

  @override
  Widget build(BuildContext context) {

    final BMIBloc bmiBloc = BlocProvider.of<BMIBloc>(context);
    return Expanded(
      child: CustomContainer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('HEIGHT'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                '${currentValue.toInt()}',
                style: TextStyle(
                    fontSize: 40,
                    color: KWhiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'cm',
                style: TextStyle(color: KTitleColor),
              )
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              inactiveTrackColor: KInactiveTrackColor,
              activeTrackColor: KWhiteColor,
              thumbColor: KAccentColor,
              overlayColor: KAccentColor.withAlpha((255 / 8).floor()),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 22),
            ),
            child: Slider(
                value: currentValue,
                min: 100.0,
                max: 220.0,
                onChangeEnd: (value) {
                  (bmiBloc.currentState as BMIPage).bmi.height = value.toInt();
                },
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                }),
          )
        ],
      )),
    );
  }
}

class ThirdWidgetItem extends StatefulWidget {
  final CounterType counterType;

  const ThirdWidgetItem({Key key, this.counterType}) : super(key: key);

  @override
  _ThirdWidgetItemState createState() => _ThirdWidgetItemState();
}

class _ThirdWidgetItemState extends State<ThirdWidgetItem> {
  CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BMIBloc bmiBloc = BlocProvider.of<BMIBloc>(context);
    saveData(int value) {
      if (widget.counterType == CounterType.weight) {
        (bmiBloc.currentState as BMIPage).bmi.weight = counterBloc.currentState;
      } else {
        (bmiBloc.currentState as BMIPage).bmi.age = counterBloc.currentState;
      }
    }

    counterBloc.state.listen(saveData);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(widget.counterType.toString().substring(12)),
        BlocBuilder(
          bloc: counterBloc,
          builder: (BuildContext context, int state) => Text(
                state.toString(),
                style: TextStyle(
                    fontSize: 30,
                    color: KWhiteColor,
                    fontWeight: FontWeight.bold),
              ),
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              icon: FontAwesomeIcons.minus,
              onPress: () {
                counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
            SizedBox(
              width: 10,
            ),
            RoundedButton(
              icon: Icons.add,
              onPress: () {
                counterBloc.dispatch(CounterEvent.increment);
              },
            )
          ],
        )
      ],
    );
  }
}

class ThirdRowWidget extends StatelessWidget {
  const ThirdRowWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: CustomContainer(
            child: ThirdWidgetItem(
              counterType: CounterType.weight,
            ),
          )),
          Expanded(
              child: CustomContainer(
            child: ThirdWidgetItem(
              counterType: CounterType.age,
            ),
          ))
        ],
      ),
    );
  }
}

class FourItem extends StatelessWidget {
  const FourItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bmiBloc = BlocProvider.of<BMIBloc>(context);
    return BottomButton(
      onPress: () {
        print((bmiBloc.currentState as BMIPage).bmi.toString());
        bmiBloc.dispatch(BMIResult((bmiBloc.currentState as BMIPage).bmi));
      },
      title: 'CALCULATE',
    );
  }
}
