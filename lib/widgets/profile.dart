import 'package:dojos_and_dragons/model/ability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';

import '../model/adventurer.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final adventurer = Provider.of<Adventurer>(context);
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
            '${adventurer.personaLevel}',
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
                  adventurer.abilities[Ability.push]!,
                  adventurer.abilities[Ability.pull]!,
                  adventurer.abilities[Ability.core]!,
                  adventurer.abilities[Ability.legs]!,
                  adventurer.abilities[Ability.stam]!,
                  adventurer.abilities[Ability.flex]!,
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
  }
}
