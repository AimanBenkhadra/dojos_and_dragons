import 'package:flutter/cupertino.dart';

import './adventurer.dart';
import './skill.dart';
import './skills.dart';

class Adventurers with ChangeNotifier {
  final adventurers = [
    Adventurer(
      id: '001',
      firstName: 'Aiman',
      lastName: 'Benkhadra',
      adventurerFirstName: 'Darvin',
      adventurerLastName: 'Buckdragon',
      height: 180,
      weight: 75,
      skills: {
        SkillName.pushUp: 10,
        SkillName.pullUp: 9,
      },
    ),
  ];

  Adventurer currentAdventurer = Adventurer(id: '000');

  void setCurrentAdventurer(String id) {
    currentAdventurer = adventurers.firstWhere((adv) => adv.id == id);
    notifyListeners();
  }
}
