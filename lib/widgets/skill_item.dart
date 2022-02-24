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
    final Adventurer currAdv = Provider.of<Adventurers>(context)
        .adventurers
        .firstWhere((adv) => adv.id == Provider.of<Auth>(context).userId);
    final skillsInfo = Provider.of<Skills>(context, listen: false);
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context)
              .pushNamed(QiChargeScreen.routeName, arguments: skill.name);
        },
        leading: const CircleAvatar(),
        title: Text(skill.nameString),
        subtitle: Text('Max Reps: ${currAdv.skills[skill.name]}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(),
            Text('Lvl: ${skillsInfo.levelOfSkillWithWeight(
              skill.name,
              currAdv.gender,
              79,
              currAdv.skills[skill.name] ?? 0,
            )}'),
            Spacer(),
            CircleAvatar(
              radius: 10,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
