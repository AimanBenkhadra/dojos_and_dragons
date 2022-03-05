import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Map<Ability, int> abilities;
  Map<SkillName, Map<String, dynamic>> skills;

  Adventurer({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.gender = Gender.M,
    this.adventurerFirstName = '',
    this.adventurerLastName = '',
    this.height = 0,
    this.weight = 0,
    this.skills = const {},
    this.abilities = const {},
  });

  String get fName => firstName;

  int get personaLevel {
    int levels = abilities.values.reduce((a, b) => a + b);
    return levels ~/ abilities.length;
  }

  Future<bool> tryAbilityLvlUp(Skill skill, int lvl) async {
    print('abilities[skill.associatedAbility] = '
        'abilities[${skill.associatedAbility}] = '
        '${abilities[skill.associatedAbility]}');
    final _lvlUp = lvl > abilities[skill.associatedAbility]!;

    if (_lvlUp) {
      final String abilString;
      switch (skill.associatedAbility) {
        case Ability.core:
          abilString = 'core';
          break;
        case Ability.flex:
          abilString = 'flex';
          break;
        case Ability.legs:
          abilString = 'legs';
          break;
        case Ability.pull:
          abilString = 'pull';
          break;
        case Ability.push:
          abilString = 'push';
          break;
        case Ability.stam:
          abilString = 'stam';
          break;
        default:
          abilString = 'err';
      }
      await FirebaseFirestore.instance
          .collection('adventurers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'abilities.$abilString': lvl});
      abilities[skill.associatedAbility] = lvl;
      notifyListeners();
    }
    return _lvlUp;
  }

  void abilityLevelUp(Ability ability) {
    abilities[ability] = abilities[ability]! + 1;
    notifyListeners();
  }
}
