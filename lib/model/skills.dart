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
      name: SkillName.bodyweightSquat,
      associatedAbility: Ability.legs,
      measurement: Measurement.rep,
      weightChart: {
        Gender.F: {
          40: [1, 6, 40, 88, 146],
          45: [1, 7, 40, 85, 139],
          50: [1, 8, 40, 82, 132],
          55: [1, 9, 39, 79, 126],
          60: [1, 9, 39, 77, 121],
          65: [1, 10, 38, 74, 116],
          70: [1, 10, 37, 71, 111],
          75: [1, 10, 36, 69, 107],
          80: [1, 10, 35, 67, 103],
          85: [1, 10, 34, 64, 99],
          90: [1, 10, 33, 62, 96],
          95: [1, 10, 32, 60, 92],
          100: [1, 9, 31, 59, 89],
          105: [1, 9, 30, 57, 87],
          110: [1, 9, 29, 55, 84],
          115: [1, 9, 29, 53, 81],
          120: [1, 9, 28, 52, 79],
        },
        Gender.M: {
          50: [1, 15, 57, 112, 178],
          55: [1, 17, 56, 109, 170],
          60: [1, 18, 56, 106, 164],
          65: [1, 18, 55, 103, 157],
          70: [1, 19, 54, 100, 152],
          75: [1, 19, 53, 97, 146],
          80: [1, 19, 52, 94, 142],
          85: [1, 19, 51, 91, 137],
          90: [1, 19, 50, 89, 133],
          95: [1, 19, 49, 86, 129],
          100: [1, 19, 48, 84, 125],
          105: [1, 19, 47, 82, 121],
          110: [1, 19, 46, 80, 118],
          115: [1, 18, 45, 78, 115],
          120: [1, 18, 44, 76, 112],
          125: [1, 18, 43, 74, 109],
          130: [1, 17, 42, 72, 106],
          135: [1, 17, 41, 71, 103],
          140: [1, 17, 40, 69, 101],
        },
      },
    ),
    Skill(
      name: SkillName.squat,
      associatedAbility: Ability.legs,
      measurement: Measurement.rm1,
      weightChart: {
        Gender.F: {
          40: [18, 32, 51, 75, 101],
          45: [21, 36, 56, 81, 109],
          50: [24, 40, 61, 87, 115],
          55: [27, 43, 65, 92, 122],
          60: [29, 47, 70, 97, 127],
          65: [32, 50, 74, 102, 133],
          70: [34, 53, 78, 106, 138],
          75: [37, 56, 81, 111, 143],
          80: [39, 59, 85, 115, 148],
          85: [42, 62, 88, 119, 152],
          90: [44, 65, 92, 123, 156],
          95: [46, 68, 95, 126, 161],
          100: [48, 70, 98, 130, 164],
          105: [50, 73, 101, 133, 168],
          110: [52, 75, 103, 136, 172],
          115: [54, 77, 106, 139, 175],
          120: [56, 80, 109, 143, 179],
        },
        Gender.M: {
          50: [33, 51, 75, 103, 134],
          55: [39, 59, 84, 114, 147],
          60: [46, 67, 94, 125, 159],
          65: [52, 75, 103, 136, 171],
          70: [58, 82, 112, 146, 183],
          75: [65, 90, 120, 156, 194],
          80: [71, 97, 129, 165, 204],
          85: [77, 104, 137, 174, 214],
          90: [83, 111, 145, 183, 224],
          95: [88, 117, 152, 192, 233],
          100: [94, 124, 160, 200, 242],
          105: [99, 130, 167, 208, 251],
          110: [105, 136, 174, 216, 260],
          115: [110, 142, 181, 223, 268],
          120: [115, 148, 187, 231, 276],
          125: [120, 154, 194, 238, 284],
          130: [125, 160, 200, 245, 292],
          135: [130, 165, 206, 252, 299],
          140: [135, 171, 212, 258, 307],
        },
      },
    ),
  ];

  List<Skill> get skills => [..._skills];

  int levelOfSkillWithWeight(
    SkillName skillName,
    Gender gender,
    double weight,
    double result,
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

  double to1RM(int reps, double weight) {
    final percentage = rm1percentage(reps);
    print((weight * 0.453592 * percentage / 100).toStringAsFixed(2));
    return double.parse(
        (weight * 0.453592 * percentage / 100).toStringAsFixed(2));
  }

  int rm1percentage(int reps) {
    switch (reps) {
      case 1:
        return 100;
      case 2:
        return 97;
      case 3:
        return 94;
      case 4:
        return 92;
      case 5:
        return 89;
      case 6:
        return 86;
      case 7:
        return 83;
      case 8:
        return 81;
      case 9:
        return 78;
      case 10:
        return 75;
      case 11:
        return 73;
      case 12:
        return 71;
      case 13:
        return 70;
      case 14:
        return 68;
      case 15:
        return 67;
      case 16:
        return 65;
      case 17:
        return 64;
      case 18:
        return 63;
      case 19:
        return 61;
      case 20:
        return 60;
      case 21:
        return 59;
      case 22:
        return 58;
      case 23:
        return 57;
      case 24:
        return 56;
      case 25:
        return 55;
      case 26:
        return 54;
      case 27:
        return 53;
      case 28:
        return 52;
      case 29:
        return 51;
      case 30:
        return 50;
      default:
        return 0;
    }
  }
}
