import 'package:dojos_and_dragons/model/measurement.dart';
import 'package:dojos_and_dragons/model/skill.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/skill.dart';
import '../model/skills.dart';

class QiChargeScreen extends StatefulWidget {
  static const routeName = '/qi-charge';

  @override
  _QiChargeScreenState createState() => _QiChargeScreenState();
}

class _QiChargeScreenState extends State<QiChargeScreen> {
  /// The list of skills that will be initiated in initState
  late List<Skill> skillsInfo;

  /// The key for the form
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final _repController = TextEditingController();
  final _weightController = TextEditingController();
  final _lvlController = TextEditingController();
  final _minController = TextEditingController();
  final _secController = TextEditingController();

  /// Focus Nodes
  final _repFocus = FocusNode();
  final _weightFocus = FocusNode();
  final _lvlFocus = FocusNode();
  final _minFocus = FocusNode();
  final _secFocus = FocusNode();

  @override
  void initState() {
    skillsInfo = Provider.of<Skills>(context, listen: false).skills;
    super.initState();
  }

  @override
  void dispose() {
    /// Dispose of the controllers
    _repController.dispose();
    _weightController.dispose();
    _lvlController.dispose();
    _minController.dispose();
    _secController.dispose();

    /// Dispose of the focis nodes
    _repFocus.dispose();
    _weightFocus.dispose();
    _lvlFocus.dispose();
    _minFocus.dispose();
    _secFocus.dispose();

    /// Calling the super function
    super.dispose();
  }

  void _charge() {}

  @override
  Widget build(BuildContext context) {
    /// Recuperate the skill name that was sent through the SkillItem widget
    /// (for now)
    final skillName = ModalRoute.of(context)?.settings.arguments as SkillName;

    /// Get the skill object according to the skill name
    final skill = skillsInfo.firstWhere((s) => s.name == skillName);
    return Scaffold(
      appBar: AppBar(
        title: Text(skill.nameString),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        /// Beginning of the form
        child: Form(
          key: _formKey,

          /// Beginning of the column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),

              /// Instructions
              Card(
                elevation: 8,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    skill.instructions,
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              /// Beginnning of the form fields

              /// Repetitions
              if (skill.measurement == Measurement.rep ||
                  skill.measurement == Measurement.rm1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: TextFormField(
                      controller: _repController,
                      focusNode: _repFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: false,
                      ),
                      textAlign: TextAlign.center,
                      textInputAction: skill.measurement == Measurement.rm1
                          ? TextInputAction.next
                          : TextInputAction.done,
                      validator: (rep) {
                        if (rep != null || rep!.isEmpty) {
                          return '--- enter a number';
                        } else if (int.tryParse(rep) == null) {
                          return '--- this is not a valid number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        labelText: 'repetitions',
                      ),
                    ),
                  ),
                ),

              /// Weight
              if (skill.measurement == Measurement.rm1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: TextFormField(
                      controller: _weightController,
                      focusNode: _weightFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                      ),
                      textAlign: TextAlign.center,
                      validator: (weight) {
                        if (weight != null || weight!.isEmpty) {
                          return '--- enter a weight';
                        } else if (double.tryParse(weight) == null) {
                          return '--- this is not a valid weight';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        labelText: 'weight',
                      ),
                    ),
                  ),
                ),

              /// Level
              if (skill.measurement == Measurement.lvl)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: TextFormField(
                      controller: _lvlController,
                      focusNode: _lvlFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                      ),
                      textAlign: TextAlign.center,
                      validator: (lvl) {
                        if (lvl != null || lvl!.isEmpty) {
                          return '--- enter a level';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        labelText: 'level',
                      ),
                    ),
                  ),
                ),

              /// Minutes
              if (skill.measurement == Measurement.min)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: TextFormField(
                      controller: _minController,
                      focusNode: _minFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                      ),
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      validator: (min) {
                        if (min != null || min!.isEmpty) {
                          return '--- enter a number of minutes';
                        } else if (int.tryParse(min) == null) {
                          return '--- this is not a valid number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        labelText: 'minutes',
                      ),
                    ),
                  ),
                ),

              /// Seconds
              if (skill.measurement == Measurement.min ||
                  skill.measurement == Measurement.sec)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: TextFormField(
                      controller: _secController,
                      focusNode: _secFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                      ),
                      textAlign: TextAlign.center,
                      validator: (sec) {
                        if ((sec != null || sec!.isEmpty) &&
                            skill.measurement == Measurement.sec) {
                          return '--- enter a number of seconds';
                        } else if (int.tryParse(sec) == null) {
                          return '--- this is not a valid number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColorLight,
                        filled: true,
                        labelText: 'seconds',
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: _charge,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    height: 96,
                    width: 96,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                        child: Text(
                      'Charge!',
                      style: Theme.of(context).textTheme.labelLarge,
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
