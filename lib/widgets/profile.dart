import 'package:dojos_and_dragons/model/ability.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/adventurer.dart';
import '../model/auth.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final firestore = FirebaseFirestore.instance;
  // final fAuth = FirebaseAuth.instance;
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    // final adventurer = Provider.of<Adventurer>(context);
    // final loggedAdventurer = fAuth.currentUser;
    // final adventurers = firestore.collection('adventurers');

    // return FutureBuilder(
    //     future: Provider.of<Auth>(context).loadAdventurer(),
    //     builder: (ctx, AsyncSnapshot<Adventurer> adventurerSnapshot) {
    //       if (adventurerSnapshot.hasError) {
    //         return const Center(
    //           child: Text('Something went wrong...'),
    //         );
    //       }

    //       // if (adventurer.hasData) {
    //       //   return const Center(
    //       //     child: Text('This adventurer does not exist...'),
    //       //   );
    //       // }

    //       if (adventurerSnapshot.connectionState == ConnectionState.done) {
    //         final adventurer = adventurerSnapshot.data!;
    // final adventurer = Provider.of<Auth>(context).adventurer;
    return FutureBuilder(
      future: Provider.of<Auth>(context, listen: false).loadAdventurer(),
      builder: (context, AsyncSnapshot<void> snap) {
        if (snap.connectionState == ConnectionState.done) {
          final adventurer = Provider.of<Auth>(context).adventurer;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${adventurer.adventurerFirstName} ${adventurer.adventurerLastName.toUpperCase()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Text(
                  'Persona',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  adventurer.personaLevel.toString(),
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
                        adventurer.abilities[Ability.push]!.toInt(),
                        adventurer.abilities[Ability.pull]!.toInt(),
                        adventurer.abilities[Ability.core]!.toInt(),
                        adventurer.abilities[Ability.legs]!.toInt(),
                        adventurer.abilities[Ability.stam]!.toInt(),
                        adventurer.abilities[Ability.flex]!.toInt(),
                      ]
                    ],
                  ),
                ),
                Text(
                  'aka ${adventurer.firstName} ${adventurer.lastName.toUpperCase()}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  // return const Center(
  //   child: CircularProgressIndicator(),
  // );
}
  //       );
  // }
// }
