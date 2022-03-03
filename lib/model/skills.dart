import 'package:flutter/cupertino.dart';

import './ability.dart';
import './gender.dart';
import './measurement.dart';
import './skill.dart';

class Skills with ChangeNotifier {
  final _skills = [
    Skill(
      name: SkillName.pushUp,
      associatedAbility: Ability.push,
      measurement: Measurement.rep,
      weightChart: {
        Gender.F: {
          40: [1, 5, 20, 40, 62],
          45: [1, 6, 20, 39, 59],
          50: [1, 6, 20, 37, 56],
          55: [1, 6, 19, 36, 54],
          60: [1, 6, 18, 34, 51],
          65: [1, 6, 18, 33, 49],
          70: [1, 6, 17, 31, 47],
          75: [1, 6, 16, 30, 45],
          80: [1, 5, 16, 29, 43],
          85: [1, 5, 15, 27, 41],
          90: [1, 5, 14, 26, 39],
          95: [1, 4, 13, 25, 38],
          100: [1, 4, 13, 24, 36],
          105: [1, 4, 12, 23, 35],
          110: [1, 3, 11, 22, 33],
          115: [1, 3, 11, 21, 32],
          120: [1, 3, 10, 20, 31],
        },
        Gender.M: {
          50: [1, 14, 41, 74, 111],
          55: [1, 16, 41, 73, 108],
          60: [1, 17, 41, 71, 104],
          65: [1, 17, 41, 69, 101],
          70: [1, 18, 40, 68, 98],
          75: [2, 18, 40, 66, 95],
          80: [2, 18, 39, 65, 92],
          85: [3, 18, 39, 63, 90],
          90: [3, 18, 38, 61, 87],
          95: [4, 18, 37, 60, 85],
          100: [4, 18, 37, 59, 82],
          105: [4, 18, 36, 57, 80],
          110: [4, 17, 35, 56, 78],
          115: [4, 17, 34, 54, 76],
          120: [4, 17, 34, 53, 74],
          125: [4, 16, 33, 52, 72],
          130: [4, 16, 32, 51, 71],
          135: [4, 16, 32, 50, 69],
          140: [4, 15, 31, 48, 67],
        },
      },
    ),
    Skill(
      name: SkillName.pullUp,
      associatedAbility: Ability.pull,
      measurement: Measurement.rep,
      weightChart: {
        Gender.F: {
          40: [0, 1, 6, 14, 24],
          45: [0, 1, 6, 14, 24],
          50: [0, 1, 6, 14, 23],
          55: [0, 1, 6, 13, 22],
          60: [0, 1, 6, 13, 21],
          65: [0, 1, 6, 12, 20],
          70: [0, 1, 6, 12, 19],
          75: [0, 1, 5, 11, 18],
          80: [0, 1, 5, 10, 17],
          85: [0, 1, 5, 10, 16],
          90: [0, 1, 4, 10, 16],
          95: [0, 1, 4, 9, 15],
          100: [0, 1, 4, 9, 14],
          105: [0, 1, 3, 8, 13],
          110: [0, 1, 3, 8, 12],
          115: [0, 1, 2, 7, 12],
          120: [0, 1, 2, 7, 11],
        },
        Gender.M: {
          50: [1, 5, 14, 26, 39],
          55: [1, 5, 14, 25, 38],
          60: [1, 6, 14, 25, 36],
          65: [1, 6, 14, 24, 35],
          70: [1, 6, 14, 24, 34],
          75: [1, 6, 13, 23, 33],
          80: [1, 6, 13, 22, 32],
          85: [1, 6, 12, 21, 31],
          90: [1, 5, 12, 21, 30],
          95: [1, 5, 12, 20, 29],
          100: [1, 5, 11, 19, 28],
          105: [1, 5, 11, 19, 27],
          110: [1, 5, 10, 18, 26],
          115: [1, 4, 10, 17, 25],
          120: [1, 4, 10, 17, 24],
          125: [1, 4, 9, 16, 23],
          130: [1, 3, 9, 15, 22],
          135: [1, 3, 9, 15, 22],
          140: [1, 3, 8, 14, 21],
        },
      },
    ),
    Skill(
      name: SkillName.airSquat,
      associatedAbility: Ability.legs,
      measurement: Measurement.rep,
      weightChart: {
        Gender.F: {
          40: [0, 1, 6, 14, 24],
          45: [0, 1, 6, 14, 24],
          50: [0, 1, 6, 14, 23],
          55: [0, 1, 6, 13, 22],
          60: [0, 1, 6, 13, 21],
          65: [0, 1, 6, 12, 20],
          70: [0, 1, 6, 12, 19],
          75: [0, 1, 5, 11, 18],
          80: [0, 1, 5, 10, 17],
          85: [0, 1, 5, 10, 16],
          90: [0, 1, 4, 10, 16],
          95: [0, 1, 4, 9, 15],
          100: [0, 1, 4, 9, 14],
          105: [0, 1, 3, 8, 13],
          110: [0, 1, 3, 8, 12],
          115: [0, 1, 2, 7, 12],
          120: [0, 1, 2, 7, 11],
        },
        Gender.M: {
          50: [1, 5, 14, 26, 39],
          55: [1, 5, 14, 25, 38],
          60: [1, 6, 14, 25, 36],
          65: [1, 6, 14, 24, 35],
          70: [1, 6, 14, 24, 34],
          75: [1, 6, 13, 23, 33],
          80: [1, 6, 13, 22, 32],
          85: [1, 6, 12, 21, 31],
          90: [1, 5, 12, 21, 30],
          95: [1, 5, 12, 20, 29],
          100: [1, 5, 11, 19, 28],
          105: [1, 5, 11, 19, 27],
          110: [1, 5, 10, 18, 26],
          115: [1, 4, 10, 17, 25],
          120: [1, 4, 10, 17, 24],
          125: [1, 4, 9, 16, 23],
          130: [1, 3, 9, 15, 22],
          135: [1, 3, 9, 15, 22],
          140: [1, 3, 8, 14, 21],
        },
      },
    ),
  ];

  List<Skill> get skills => [..._skills];

  int levelOfSkillWithWeight(
    SkillName skillName,
    Gender gender,
    int weight,
    int result,
  ) {
    var _isBelowRange = false;
    var _isAboveRange = false;

    final skill = _skills.firstWhere((s) => s.name == skillName);
    final wChart = skill.weightChart;
    final gChart = wChart[gender];
    final weights = gChart!.keys.toList()..sort();
    var minWeight;
    var maxWeight;
    if (weights[0] > weight) {
      maxWeight = weights[0];
      _isBelowRange = true;
    } else if (weights.last < weight) {
      minWeight = weights.last;
      _isAboveRange = true;
    } else {
      for (int weightI = 0; weightI < weights.length; weightI++) {
        if (weight >= weights[weightI] && weight <= weights[weightI + 1]) {
          minWeight = weights[weightI];
          // print('minWeight: $minWeight');
          maxWeight = weights[weightI + 1];
          // print('maxWeight: $maxWeight');
        }
      }
      if (!_isAboveRange && !_isBelowRange) {
        final ds = (weight - minWeight) / (maxWeight - minWeight);
        final minWeigthStats = gChart[minWeight];
        // print('minWeigthStats: $minWeigthStats');
        final maxWeigthStats = gChart[maxWeight];
        // print('maxWeigthStats: $maxWeigthStats');
        final wThresholds = [
          for (int i = 0; i < 5; i++)
            (minWeigthStats![i] + (maxWeigthStats![i] - minWeigthStats[i]) * ds)
          // .toInt()
        ];
        // print(wThresholds);
        if (result < wThresholds.first) {
          return 0;
        } else if (result >= wThresholds.last) {
          // print('On est niveau 20');
          return 20;
        } else {
          int maxIndex = 0;
          // print('maxIndex initialisé à 0');
          for (int i = 0; i < 5; i++) {
            // print('On rentre dans la loop');
            // print('le result est $result');
            // print('wThresholds[i] est ${wThresholds[i]}');
            if (result >= wThresholds[i]) {
              maxIndex = i + 1;
              // print('La nouvelle valeur de maxIndex est $maxIndex');
            }
          }
          var dLvl = (result - wThresholds[maxIndex - 1]) /
              (wThresholds[maxIndex] - wThresholds[maxIndex - 1]);
          var maxLvl;

          switch (maxIndex) {
            case 1:
              maxLvl = 4;
              break;
            case 2:
              maxLvl = 10;
              break;
            case 3:
              maxLvl = 16;
              break;
            default:
              maxLvl = 20;
          }
          var minLvl;
          switch (maxLvl) {
            case 4:
              minLvl = 1;
              break;
            case 10:
              minLvl = 4;
              break;
            case 16:
              minLvl = 10;
              break;
            default:
              minLvl = 16;
          }
          var Lvl = (minLvl + (maxLvl - minLvl) * dLvl).toInt();
          return Lvl;
        }
      }
    }
    return 0;
  }
}
