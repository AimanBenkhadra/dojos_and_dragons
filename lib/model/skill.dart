import './ability.dart';
import './measurement.dart';
import './gender.dart';

enum SkillName {
  pushUp,
  pullUp,
  airSquat,
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
      case SkillName.airSquat:
        return 'Air Squat';
      default:
        return 'Unknown Skill';
    }
  }
}
