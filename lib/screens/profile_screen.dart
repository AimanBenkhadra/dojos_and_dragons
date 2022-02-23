import 'package:flutter/material.dart';

import '../widgets/profile.dart';

// ignore: use_key_in_widget_constructors
class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doragons'),
      ),
      body: Profile(),
    );
  }
}
