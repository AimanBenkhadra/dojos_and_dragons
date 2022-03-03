import 'package:dojos_and_dragons/model/ability.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/adventurer.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestore = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final adventurer = Provider.of<Adventurer>(context);
    final loggedAdventurer = fAuth.currentUser;
    final adventurers = firestore.collection('adventurers');

    return FutureBuilder(
        future: adventurers.doc(loggedAdventurer!.uid).get(),
        builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(
              child: Text('This adventurer does not exist...'),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${snapshot.data!['adventurer first name']} ${snapshot.data!['adventurer last name'].toUpperCase()}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    'Persona',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '0',
                    style: const TextStyle(
                      fontSize: 108,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: RadarChart(
                      ticks: const [4, 10, 16, 20],
                      features: const [
                        'push',
                        'pull',
                        'core',
                        'legs',
                        'stam',
                        'flex',
                      ],
                      data: [
                        [
                          snapshot.data!['abilities']['push'],
                          snapshot.data!['abilities']['pull'],
                          snapshot.data!['abilities']['core'],
                          snapshot.data!['abilities']['legs'],
                          snapshot.data!['abilities']['stam'],
                          snapshot.data!['abilities']['flex'],
                        ]
                      ],
                    ),
                  ),
                  Text(
                    'aka ${snapshot.data!['first name']} ${snapshot.data!['last name'].toUpperCase()}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('...loading...'),
          );
        });
  }
}
