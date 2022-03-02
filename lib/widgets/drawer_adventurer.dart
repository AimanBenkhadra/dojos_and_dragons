import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/profile_screen.dart';
import '../screens/qi_screen.dart';

class DrawerAdventurer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.2,
            title: Text(
              'Dojos\nand\nDragons',
              style: Theme.of(context).textTheme.headline4,
              softWrap: true,
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              size: max(
                MediaQuery.of(context).size.height * 0.07,
                MediaQuery.of(context).size.width * 0.07,
              ),
            ),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.fireplace_outlined,
              size: max(
                MediaQuery.of(context).size.height * 0.07,
                MediaQuery.of(context).size.width * 0.07,
              ),
            ),
            title: Text(
              'Qi',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(QiScreen.routeName);
            },
          ),
          const Divider(),
          const Spacer(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: max(
                MediaQuery.of(context).size.height * 0.07,
                MediaQuery.of(context).size.width * 0.07,
              ),
            ),
            title: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.headline6,
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
