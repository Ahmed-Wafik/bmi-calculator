import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/pages/results_page.dart';
import 'package:bmi_calculator/widgets/input_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BMIBloc bloc = BlocProvider.of<BMIBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(state is BMIPage ? 'BMI CALCULATOR' : 'BMI RESULT'),
            leading: state is BMIDetails
                ? IconButton(
                    onPressed: () => bloc.dispatch(BMIHome()),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ),
          body: state is BMIPage
              ? Column(
                  children: <Widget>[
                    FirstRowWidget(),
                    SecondWidget(),
                    ThirdRowWidget(),
                    FourItem()
                  ],
                )
              : ResultPage()),
    );
  }
}
