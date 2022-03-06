import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './ability.dart';
import './adventurer.dart';
import './gender.dart';
import './qi_gem.dart';
import './skills.dart';

class Auth with ChangeNotifier {
  /// Instantiate Firebase Auth
  final fAuth = FirebaseAuth.instance;

  /// Instantiate Firestore
  final firestore = FirebaseFirestore.instance;

  /// This will be the uid of the user
  String get uid => fAuth.currentUser!.uid;

  /// This will be the inner representation of the user's adventurer
  late Adventurer adventurer;

  Future<void> addAdventurer({
    required String advFName,
    required String advLName,
    required String firstName,
    required String lastName,
    required DateTime dob,
    required double weight,
    required String gender,
  }) async {
    try {
      await firestore.collection('adventurers').doc(uid).set({
        'adventurer first name': advFName,
        'adventurer last name': advLName,
        'first name': firstName,
        'last name': lastName,
        'birth day': dob,
        'weight': weight,
        'gender': gender,
        'abilities': {
          'push': 0,
          'pull': 0,
          'stam': 0,
          'flex': 0,
          'core': 0,
          'legs': 0,
        }
      });
      // await loadAdventurer();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadAdventurer(context) async {
    /// Instanciate the adventurer from firestore
    final fsAdventurer =
        await firestore.collection('adventurers').doc(uid).get();
    print('step 1 done');
    final qiGemIds = fsAdventurer.data()!['qi gems'];
    print('step 2 done');
    final qiGems = await firestore.collection('qi gems').get();
    print('step 3 done');
    // print('core');
    // print(fsAdventurer.get(FieldPath(['abilities', 'core'])));
    // print('flex');
    // print(fsAdventurer.get(FieldPath(['abilities', 'flex'])));
    // print('legs');
    // print(fsAdventurer.get(FieldPath(['abilities', 'legs'])));
    // print('pull');
    // print(fsAdventurer.get(FieldPath(['abilities', 'pull'])));
    // print('push');
    // print(fsAdventurer.get(FieldPath(['abilities', 'push'])));
    // print('stam');
    // print(fsAdventurer.get(FieldPath(['abilities', 'stam'])));

    adventurer = Adventurer(
      id: uid,
      firstName: fsAdventurer.get('first name'),
      lastName: fsAdventurer.get('last name'),
      gender: fsAdventurer.get('gender') == 'M' ? Gender.M : Gender.F,
      adventurerFirstName: fsAdventurer.get('adventurer first name'),
      adventurerLastName: fsAdventurer.get('adventurer last name'),
      weight: fsAdventurer.get('weight'),
      abilities: {
        Ability.core: fsAdventurer.get(FieldPath(['abilities', 'core'])),
        Ability.flex: fsAdventurer.get(FieldPath(['abilities', 'flex'])),
        Ability.legs: fsAdventurer.get(FieldPath(['abilities', 'legs'])),
        Ability.pull: fsAdventurer.get(FieldPath(['abilities', 'pull'])),
        Ability.push: fsAdventurer.get(FieldPath(['abilities', 'push'])),
        Ability.stam: fsAdventurer.get(FieldPath(['abilities', 'stam'])),
      },
      qiGems: [],
    );
    print('step 4 done');
    for (var qiGem in qiGems.docs.map((e) => e.data())) {
      print('For loop iteration start!');
      final inSkill = Provider.of<Skills>(context, listen: false)
          .fromString(qiGem['skill'])!;
      print('inSkill: $inSkill');
      final inBW = qiGem['body weight'];
      print('inBW: $inBW');
      final inReps = qiGem['reps'];
      print('inReps: $inReps');
      final inWeight = qiGem['weight'];
      print('inWeight: $inWeight');
      // final inWhenTS = qiGem['when'] as Timestamp;
      // print('inWhenTS: $inWhenTS');
      final inWhen = (qiGem['when'] as Timestamp).toDate();
      print('inWhen: $inWhen');
      final inLevel = qiGem['level'];
      print('inLevel: $inLevel');

      adventurer.qiGems.add(
        QiGem(
          skill: inSkill,
          bw: inBW,
          reps: inReps,
          weight: inWeight,
          when: inWhen,
          level: inLevel,
        ),
      );
      print('For loop iteration end!');
    }
    print('step 5 done');
    // print('core');
    // print(adventurer.abilities[Ability.core]);
    // print('flex');
    // print(adventurer.abilities[Ability.flex]);
    // print('legs');
    // print(adventurer.abilities[Ability.legs]);
    // print('pull');
    // print(adventurer.abilities[Ability.pull]);
    // print('push');
    // print(adventurer.abilities[Ability.push]);
    // print('stam');
    // print(adventurer.abilities[Ability.stam]);
  }
}
