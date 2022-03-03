import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './http_exception.dart';

class Auth with ChangeNotifier {
  late String uid;
  // DateTime? _expiryDate;
  String? _userId = 'u5oGEG8gfb15qIXSWZ6G';
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

  String? get userId {
    return _userId;
  }

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
      await FirebaseFirestore.instance
          .collection('adventurers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'adventurer first name': advFName,
        'adventurer last name': advLName,
        'first name': firstName,
        'last name': lastName,
        'birth day': dob,
        'weight': weight,
        'gender': gender,
      });
    } catch (e) {
      rethrow;
    }
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
      _userId = responseData['localId'];
    } catch (e) {}
  }
}
