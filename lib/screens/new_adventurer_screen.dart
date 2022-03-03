import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/auth.dart';

class NewAdventurerScreen extends StatefulWidget {
  const NewAdventurerScreen({Key? key}) : super(key: key);

  @override
  State<NewAdventurerScreen> createState() => _NewAdventurerScreenState();
}

class _NewAdventurerScreenState extends State<NewAdventurerScreen> {
  bool _loading = false;

  /// Instantiating the key for the form
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final _advFNameController = TextEditingController();
  final _advLNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _weightController = TextEditingController();
  final _genderController = TextEditingController();

  /// Focus nodes
  final _advFNameFocus = FocusNode();
  final _advLNameFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _weightFocus = FocusNode();
  final _genderFocus = FocusNode();

  /// Variable to stroe date of birth while the form is being filled
  late DateTime _dob;

  /// Overriding the dispose method to get rid of the controllers and the focus
  /// nodes
  @override
  void dispose() {
    /// Dispose of the controllers
    _advFNameController.dispose();
    _advLNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateController.dispose();
    _weightController.dispose();
    _genderController.dispose();

    /// Dispose of the focus nodes
    ///  _advFNameController.dispose();
    _advLNameFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _dateFocus.dispose();
    _weightFocus.dispose();
    _genderFocus.dispose();

    /// Call the super dispose
    super.dispose();
  }

  /// Select date of birth. This is a method because it will be used at least
  /// in two places.
  void _selectDOB(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 7000)),
      firstDate: DateTime.now().subtract(const Duration(days: 70000)),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value != null) {
          _dob = value;
          _dateController.text = DateFormat.yMMMd().format(value);
          FocusScope.of(context).requestFocus(_weightFocus);
        }
      },
    );
  }

  /// Function to create the adventurer and start adventuring!
  Future<void> _adventure() async {
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) return;
    setState(() {
      _loading = true;
    });
    await Provider.of<Auth>(context, listen: false).addAdventurer(
      advFName: _advFNameController.text,
      advLName: _advLNameController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dob: _dob,
      weight: double.parse(_weightController.text),
      gender: _genderController.text.toUpperCase(),
    );
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () => FirebaseAuth.instance.signOut(),
      //       icon: Icon(Icons.exit_to_app),
      //     )
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      /// Title of the form
                      Text(
                        'Let\'s create your adventurer!',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),

                      /// Adventurer first name
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          controller: _advFNameController,
                          decoration: InputDecoration(
                            labelText: 'adventurer\'s first name',
                            hintText: 'this or a last name is necessary',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          focusNode: _advFNameFocus,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_advLNameFocus),
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty &&
                                _advLNameController.text.isEmpty) {
                              return '    this or a last name is necessary';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      /// Adventurer last name
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _advLNameController,
                          decoration: InputDecoration(
                            labelText: 'adventurer\'s last name',
                            hintText: 'this or a first name is necessary',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          focusNode: _advLNameFocus,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_firstNameFocus),
                          textAlign: TextAlign.center,
                          validator: (val) {
                            if (val!.isEmpty &&
                                _advFNameController.text.isEmpty) {
                              return '    this or a first name is necessary';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      /// Person's first name
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'your first name',
                            hintText: 'can be set up or changed later',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_lastNameFocus),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      /// Person's last name
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'your last name',
                            hintText: 'can be set up or changed later',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          onFieldSubmitted: (_) => _selectDOB(context),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      /// Date of birth
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _dateController,
                          focusNode: _dateFocus,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'date of birth',
                            hintText: 'necessary',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          readOnly: true,
                          onTap: () => _selectDOB(context),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return '    this is necessary';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      /// Person's weight
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          controller: _weightController,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'your weight in Kg',
                            hintText: 'necessary',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          focusNode: _weightFocus,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false),
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_genderFocus),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return '    please provide your weight in Kg '
                                  '(lbs * 2.23)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      /// Person's gender
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: TextFormField(
                          controller: _genderController,
                          focusNode: _genderFocus,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'your gender (F/M)',
                            hintText: 'necessary',
                            filled: true,
                            fillColor: Theme.of(context).primaryColorLight,
                          ),
                          onFieldSubmitted: (_) => _adventure(),
                          validator: (val) {
                            if (!['M', 'm', 'F', 'f'].contains(val)) {
                              return '    this must be either F or M';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (!_loading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(96.0, 96.0)),
                      maximumSize: MaterialStateProperty.all<Size>(
                          const Size(96.0, 96.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                      ),
                    ),
                    onPressed: _adventure,
                    child: const FittedBox(child: Text('Adventure!')),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        icon: const Icon(Icons.exit_to_app),
                        color: Theme.of(context).primaryColor,
                        tooltip: 'or sign out...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_loading) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
