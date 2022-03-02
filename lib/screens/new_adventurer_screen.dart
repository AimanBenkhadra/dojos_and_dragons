import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class NewAdventurerScreen extends StatefulWidget {
  const NewAdventurerScreen({Key? key}) : super(key: key);

  @override
  State<NewAdventurerScreen> createState() => _NewAdventurerScreenState();
}

class _NewAdventurerScreenState extends State<NewAdventurerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
          child: Text(
        'We will create a new adventurer here',
        textAlign: TextAlign.center,
        softWrap: true,
      )),
    );
  }
}
