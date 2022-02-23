import 'package:flutter/cupertino.dart';

import './adventurer.dart';
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
      weight: 79,
      skills: [
        'Push Up',
        'Pull Up',
      ],
    ),
  ];
}
