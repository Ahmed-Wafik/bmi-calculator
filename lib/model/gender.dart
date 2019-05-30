import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
enum Type { male, female }

class Gender {
  final Type type;
  final IconData icon;

  Gender({this.type,this.icon});
  static Gender male =Gender(icon: FontAwesomeIcons.mars,type: Type.male);
  static Gender female =Gender(icon: FontAwesomeIcons.venus,type: Type.female);

}
