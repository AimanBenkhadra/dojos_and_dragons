import './ability.dart';
import './measurement.dart';
import './gender.dart';

enum SkillName {
  pushUp,
  pullUp,
  bodyweightSquat,
  squat,
  lyingLegRaise,
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
      case SkillName.bodyweightSquat:
        return 'Bodyweight Squat';
      case SkillName.squat:
        return 'Squat';
      case SkillName.lyingLegRaise:
        return 'Lying Leg Raise';
      default:
        return 'Unknown Skill';
    }
  }

  String get instructions {
    switch (measurement) {
      case Measurement.lvl:
        return 'Do a ${nameString.toUpperCase()} and enter the level you have '
            'reached.';
      case Measurement.min:
        return 'Do a ${nameString.toUpperCase()} and enter the number of '
            'minutes it took you.';
      case Measurement.rep:
        return 'Do as many ${nameString.toUpperCase()}s as you can and enter '
            'the number of reps you were able to do.';
      case Measurement.rm1:
        return 'Do ${nameString.toUpperCase()}s and enter the number of reps '
            'you were able to da as well as the weight used.';
      case Measurement.sec:
        return 'Do a ${nameString.toUpperCase()} and enter the number of '
            'seconds it took you.';
      default:
        return 'Not sure what you should do...';
    }
  }
}
