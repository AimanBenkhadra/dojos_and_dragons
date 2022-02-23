import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Darvin BUCKDRAGON',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'aka Aiman BENKHADRA',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'Persona Level',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          '6',
          style: TextStyle(
            fontSize: 108,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: RadarChart(
            ticks: [4, 10, 16, 20],
            features: [
              'push',
              'pull',
              'core',
              'legs',
              'stam',
              'flex',
            ],
            data: [
              [7, 5, 11, 11, 14, 8]
            ],
          ),
        ),
      ],
    ));
  }
}
