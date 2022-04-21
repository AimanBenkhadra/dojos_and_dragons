import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: use_key_in_widget_constructors
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

        if (auth.currentUser != null && !auth.currentUser!.emailVerified) {
          setState(() {
            _isAuthLoading = true;
          });
          await auth.currentUser!.sendEmailVerification();
          setState(() {
            _isAuthLoading = false;
          });
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Verifying...'),
              content: Text(
                'An email was sent to ${_emailController.text}. Please'
                ' confirm your email address by clicking on the link in the '
                'email and then sign up.',
                softWrap: true,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          setState(() {
            _signingUp = false;
          });
        }
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
        if (auth.currentUser != null && !auth.currentUser!.emailVerified) {
          setState(() {
            _isAuthLoading = true;
          });
          await auth.currentUser!.sendEmailVerification();
          setState(() {
            _isAuthLoading = false;
          });
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Verifying...'),
              content: Text(
                'An email was sent to ${_emailController.text}. Please'
                ' confirm your email address by clicking on the link in the '
                'email and then sign up.',
                softWrap: true,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          setState(() {
            _signingUp = false;
          });
        }
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

  /// Signin with Google+
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await linkAccounts(credential);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Link accounts
  Future linkAccounts(credential) async {
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
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

              /// Google+ button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 32),
                // clipBehavior: Clip.antiAlias,
                // decoration: BoxDecoration(shape: BoxShape.circle),
                // borderRadius: BorderRadius.circular(32),
                child: ElevatedButton.icon(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  icon: Icon(FontAwesomeIcons.googlePlus),
                  label: Text('Google+'),
                ),
              ),

              /// Some space after button
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      indent: 16,
                      endIndent: 16,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text('OR'),
                  ),
                  const Expanded(
                    child: Divider(
                      indent: 16,
                      endIndent: 16,
                    ),
                  ),
                ],
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
                    onFieldSubmitted: (_) {
                      if (_signingUp) {
                        FocusScope.of(context).requestFocus(_repeatPwFocus);
                      } else {
                        _go();
                      }
                    },
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
