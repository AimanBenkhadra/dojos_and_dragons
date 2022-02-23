import './adventurer.dart';
import './skills.dart';

class Adventurers {
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
        Skills().skills.firstWhere((skill) => skill.name == 'Push Up'),
      ],
    ),
  ];
}
