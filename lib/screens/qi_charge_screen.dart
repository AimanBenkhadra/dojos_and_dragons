import 'package:dojos_and_dragons/model/skill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/skill.dart';
import '../model/skills.dart';

class QiChargeScreen extends StatefulWidget {
  static const routeName = '/qi-charge';

  @override
  _QiChargeScreenState createState() => _QiChargeScreenState();
}

class _QiChargeScreenState extends State<QiChargeScreen> {
  List<Skill> skillsInfo = [];
  @override
  void initState() {
    skillsInfo = Provider.of<Skills>(context, listen: false).skills;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final skillName = ModalRoute.of(context)?.settings.arguments as SkillName;
    final skill = skillsInfo.firstWhere((s) => s.name == skillName);
    return Scaffold(
      appBar: AppBar(
        title: Text(skill.nameString),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(child: Text('You will do whatever I tell you to')),
          ],
        ),
      ),
    );
  }
}
