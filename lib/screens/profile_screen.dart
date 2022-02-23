import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/adventurer.dart';
import '../model/adventurers.dart';
import '../model/auth.dart';
import '../widgets/drawer_adventurer.dart';
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
      drawer: DrawerAdventurer(),
      body: ChangeNotifierProvider<Adventurer>.value(
        value: Provider.of<Adventurers>(context).adventurers.firstWhere(
            (a) => a.id == Provider.of<Auth>(context, listen: false).userId),
        child: Profile(),
      ),
    );
  }
}
