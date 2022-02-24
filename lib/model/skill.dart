import './ability.dart';
import './measurement.dart';
import './gender.dart';

enum SkillName {
  pushUp,
  pullUp,
}

class Skill {
  SkillName name;
  Ability associatedAbility;
  Measurement measurement;
  Map<Gender, Map<int, List<int>>> weightChart;

  Skill({
    required this.name,
    required this.associatedAbility,
    required this.measurement,
    required this.weightChart,
  });

  String get nameString {
    switch (name) {
      case SkillName.pushUp:
        return 'Push Up';
      case SkillName.pullUp:
        return 'Pull Up';
      default:
        return 'Unknown Skill';
    }
  }
}
