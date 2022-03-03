import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  // DateTime? _expiryDate;
  // String? _userId = 'u5oGEG8gfb15qIXSWZ6G';
  // Timer? _authTimer;

  // bool get isAuth => token != null;

  // String? get token {
  //   if (_expiryDate != null &&
  //       _expiryDate!.isAfter(DateTime.now()) &&
  //       _token != null) {
  //     return _token;
  //   }
  //   return null;
  // }

  // String? get userId {
  //   return _userId;
  // }

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
    adventurer = Adventurer(
      id: uid,
      firstName: fsAdventurer.get('first name'),
      lastName: fsAdventurer.get('last name'),
      gender: fsAdventurer.get('gender') == 'M' ? Gender.M : Gender.F,
      adventurerFirstName: fsAdventurer.get('adventurer first name'),
      adventurerLastName: fsAdventurer.get('adventurer last name'),
      weight: fsAdventurer.get('weight'),
    );
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD3tODjG2D2fleKJkqJi1IEeyATUT5uEd8');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // _token = responseData['idToken'];
      // _userId = responseData['localId'];
    } catch (e) {}
  }
}
