import './ability.dart';
import './measurement.dart';
import './gender.dart';

class Skill {
  String name;
  Ability associatedAbility;
  Measurement measurement;
  Map<Gender, Map<int, List<int>>> weightChart;

  Skill({
    required this.name,
    required this.associatedAbility,
    required this.measurement,
    required this.weightChart,
  });
}
