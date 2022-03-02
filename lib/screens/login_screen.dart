import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './profile_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Instantiate auth
  final auth = FirebaseAuth.instance;

  /// Boolean that will tell us if the user is loging in (_signingUp == false)
  /// or signing up (_signingUp == true)
  bool _signingUp = false;
  bool _isNotAnEmail = false;

  /// The key for the form field below
  final _formKey = GlobalKey<FormState>();

  /// The text controllers for the form fields below
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _repeatPwController = TextEditingController();

  /// The focus nodes
  final _emailFocus = FocusNode();
  final _pwFocus = FocusNode();
  final _repeatPwFocus = FocusNode();

  /// Authentication loading boolean
  bool _isAuthLoading = false;

  /// Overriding the dispose function to dispose of the controllers and focus
  /// nodes
  @override
  void dispose() {
    /// Dispose of the controllers
    _emailController.dispose();
    _pwController.dispose();
    _repeatPwController.dispose();

    /// Dispose of the focuse nodes
    _emailFocus.dispose();
    _pwFocus.dispose();
    _repeatPwFocus.dispose();
    super.dispose();
  }

  void _go() async {
    final _isFormValid = _formKey.currentState!.validate();
    if (!_isFormValid) return;
    setState(() => _isAuthLoading = true);
    if (_signingUp) {
      try {
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _pwController.text,
        );
      } on FirebaseAuthException catch (fbae) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${fbae.code}: ${fbae.message}',
              softWrap: true,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              softWrap: true,
            ),
          ),
        );
      }
    } else {
      try {
        await auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _pwController.text,
        );
      } on FirebaseAuthException catch (fbae) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${fbae.code}: ${fbae.message}',
              softWrap: true,
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              softWrap: true,
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        );
      }
    }
    setState(() => _isAuthLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Some space on top
              const SizedBox(height: 64.0),

              /// Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FittedBox(
                  child: Text(
                    'Dojos &\nDragons',
                    textAlign: TextAlign.center,
                    style:
                        Theme.of(context).primaryTextTheme.headline1!.copyWith(
                              color: Colors.amber[900],
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
              ),

              /// Some space after title
              const SizedBox(
                height: 16.0,
              ),

              /// Email field
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'email',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondary.withAlpha(45),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_pwFocus),
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return '    please enter an email address';
                      } else if (_isNotAnEmail) {
                        return 'this is not an email';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              /// Password field
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: TextFormField(
                    controller: _pwController,
                    decoration: InputDecoration(
                      labelText: 'password',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondary.withAlpha(45),
                    ),
                    focusNode: _pwFocus,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_repeatPwFocus),
                    textInputAction: _signingUp
                        ? TextInputAction.next
                        : TextInputAction.done,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return '    please enter a password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              /// Repeat password field
              if (_signingUp)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 8.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    child: TextFormField(
                      controller: _repeatPwController,
                      decoration: InputDecoration(
                        labelText: 'repeat password',
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(45),
                      ),
                      focusNode: _repeatPwFocus,
                      obscureText: true,
                      obscuringCharacter: '-',
                      onFieldSubmitted: (_) => _go(),
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '    please repeat the password';
                        } else if (_signingUp && val != _pwController.text) {
                          return '    the passwords do not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),

              /// Login / Sign Up button
              if (!_isAuthLoading)
                ElevatedButton(
                  onPressed: _go,
                  child: Text(_signingUp ? 'Sign Up' : 'Log In'),
                ),

              /// Switch mode button
              if (!_isAuthLoading)
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 8.0),
                  child: TextButton(
                    onPressed: () => setState(
                      () {
                        _signingUp = !_signingUp;
                      },
                    ),
                    child: Text(
                      'switch to ${_signingUp ? 'log in' : 'sign up'}',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              if (_isAuthLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
