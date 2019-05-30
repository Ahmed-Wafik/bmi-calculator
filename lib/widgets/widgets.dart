import 'package:flutter/material.dart';

import 'package:bmi_calculator/utils/constants.dart';


class RoundedButton extends StatelessWidget {
  final VoidCallback onPress;
  final IconData icon;

  const RoundedButton({Key key, this.icon, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      child: Icon(icon),
      shape: CircleBorder(),
      fillColor: KButtonColor,
      constraints: BoxConstraints.tightFor(height: 45, width: 45),
      splashColor: KAccentColor,
      elevation: 2.0,
    );
  }
}

class CustomContainer extends Container {
  final Widget child;
  final Color color;

  CustomContainer({this.child, this.color})
      : super(
            child: child,
            alignment: Alignment.center,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color ?? KCardColor));
}

class BottomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;

  const BottomButton({Key key, this.onPress, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        constraints: BoxConstraints.expand(height: 70),
        color: KAccentColor,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            letterSpacing: 1.4,
              fontSize: 25, fontWeight: FontWeight.bold, color: KWhiteColor),
        ),
      ),
    );
  }
}
