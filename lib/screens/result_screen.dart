import 'package:dojos_and_dragons/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/auth.dart';
import '../model/skills.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String skill = args['skill'];
    final int skillLvl = args['skill level'];
    final bool skillLvlUp = args['skill lu'];
    final bool abilityLvlUp = args['ability lu'];
    final bool personaLvlUp = args['persona lu'];

    final adventurer = Provider.of<Auth>(context).adventurer;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            Text(
              'You have gained a charge of ${skill.toUpperCase()} at level $skillLvl.',
              textAlign: TextAlign.center,
            ),
            if (skillLvlUp)
              Text(
                'Congratulations! You have achieved a new level for'
                ' ${skill.toUpperCase()}!',
                textAlign: TextAlign.center,
              ),
            if (abilityLvlUp)
              Text(
                'Congratulations! You have achieved a new level of the '
                '${Provider.of<Skills>(context, listen: false).skills.firstWhere((s) => s.nameString == skill).associatedAbility.name.toUpperCase()}'
                ' ability! You are now level ${adventurer.abilities[Provider.of<Skills>(context, listen: false).skills.firstWhere((s) => s.nameString == skill).associatedAbility]}!',
                textAlign: TextAlign.center,
              ),
            if (personaLvlUp)
              Text(
                'Congratulations! You have achieved a new '
                'persona level! You are now level ${adventurer.personaLevel}',
                textAlign: TextAlign.center,
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .popAndPushNamed(ProfileScreen.routeName),
              child: const Text('NICE!'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
