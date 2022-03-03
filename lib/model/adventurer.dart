import 'dart:math';

import 'package:flutter/cupertino.dart';

import './ability.dart';
import './gender.dart';
import './skill.dart';

class Adventurer with ChangeNotifier {
  String id;
  String firstName;
  String lastName;
  Gender gender;
  String adventurerFirstName;
  String adventurerLastName;
  DateTime dateOfBirth = DateTime.now();
  double height;
  double weight;
  Map<Ability, int> abilities = {for (var key in Ability.values) key: 0};
  Map<SkillName, int> skills;

  Adventurer({
    required this.id,
    this.firstName = '',
    this.lastName = '',
    this.gender = Gender.M,
    this.adventurerFirstName = '',
    this.adventurerLastName = '',
    this.height = 0,
    this.weight = 0,
    this.skills = const {},
  });

  String get fName => firstName;

  int get personaLevel {
    int levels = abilities.values.reduce((a, b) => a + b);
    return levels ~/ abilities.length;
  }
}
