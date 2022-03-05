import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojos_and_dragons/model/ability.dart';
import 'package:dojos_and_dragons/model/gender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './http_exception.dart';
import './adventurer.dart';

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

  Future<void> loadAdventurer() async {
    final fsAdventurer =
        await firestore.collection('adventurers').doc(uid).get();
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
    );
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
