import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/adventurer.dart';
import '../model/adventurers.dart';
import '../model/auth.dart';
import '../model/skill.dart';
import '../model/skills.dart';
import '../screens/qi_charge_screen.dart';

class SkillItem extends StatelessWidget {
  final Skill skill;
  SkillItem(this.skill);
  @override
  Widget build(BuildContext context) {
    final Adventurer currAdv = Provider.of<Auth>(context).adventurer;
    final skillsInfo = Provider.of<Skills>(context, listen: false);
    // return FutureBuilder(
    //   future: Provider.of<Auth>(context).adventurer,
    //   builder: (context, AsyncSnapshot<Adventurer> adventurerSnapshot) {
    //     if (adventurerSnapshot.connectionState == ConnectionState.done) {
    //       final currAdv = adventurerSnapshot.data!;
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(QiChargeScreen.routeName, arguments: skill.name);
        },
        leading: const CircleAvatar(),
        title: Text(skill.nameString),
        subtitle: Text('Max Reps: ${currAdv.skills[skill.name] ?? 0}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(),
            Text('Lvl: ${skillsInfo.levelOfSkillWithWeight(
              skill.name,
              currAdv.gender,
              79,
              currAdv.skills[skill.name] ?? 0,
            )}'),
            const Spacer(),
            const CircleAvatar(radius: 10),
            const Spacer(),
          ],
        ),
      ),
    );
  }
  //    else {
  //     return const Center(child: CircularProgressIndicator());
  //   }
  // },
  // );
  // }
}
