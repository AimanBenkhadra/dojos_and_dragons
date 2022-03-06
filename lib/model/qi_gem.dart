import 'package:dojos_and_dragons/model/measurement.dart';

import './ability.dart';
import './skill.dart';

class QiGem {
  /// The skill
  Skill skill;

  /// The name of the skill used to get the gem. ex: SkillName.pushUp
  SkillName get skillName => skill.name;

  /// The ability associated to the skill. ex: Ability.push
  Ability get ability => skill.associatedAbility;

  /// The measure used. ex: Measurement.reps
  Measurement get measurement => skill.measurement;

  /// Adventurer's body weight
  double bw;

  /// The reps, if measurement is either reps or 1 rep max
  int? reps;

  /// The weight used, if the measurement is 1 rep max
  double? weight;

  /// The moment when the gem was acquired
  DateTime when;

  /// The level of this gem. It has to be registered, because the same result
  /// might give a different level if the bw or the age changes
  int level;

  QiGem({
    required this.skill,
    required this.bw,
    this.reps,
    this.weight,
    required this.when,
    required this.level,
  });
}
