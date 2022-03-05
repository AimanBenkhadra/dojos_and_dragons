import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './firebase_options.dart';

import './model/adventurer.dart';
import './model/adventurers.dart';
import './model/auth.dart';
import './model/skills.dart';

import './screens/login_screen.dart';
import './screens/new_adventurer_screen.dart';
import './screens/profile_screen.dart';
import './screens/qi_charge_screen.dart';
import './screens/qi_screen.dart';
import './screens/result_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Adventurer Provider
        ChangeNotifierProvider(
          create: (_) => Adventurer(),
        ),

        /// Adventurers Provider
        ChangeNotifierProvider(
          create: (_) => Adventurers(),
        ),

        /// Adventurers Provider
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),

        /// Skills Provider
        ChangeNotifierProvider(
          create: (_) => Skills(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doragons',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (_, AsyncSnapshot<User?> user) {
            if (user.hasData && user.data!.emailVerified) {
              return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('adventurers')
                      .doc(user.data!.uid)
                      .get(),
                  builder:
                      (_, AsyncSnapshot<DocumentSnapshot> adventurerSnapshot) {
                    if (adventurerSnapshot.hasData &&
                        !adventurerSnapshot.data!.exists) {
                      return NewAdventurerScreen();
                    } else if (adventurerSnapshot.connectionState ==
                        ConnectionState.done) {
                      return ProfileScreen();
                    }
                    return const Scaffold(
                        body: Center(child: CircularProgressIndicator()));
                  });
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          // '/': (_) => ProfileScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
          QiScreen.routeName: (_) => QiScreen(),
          QiChargeScreen.routeName: (_) => QiChargeScreen(),
          ResultScreen.routeName: (_) => ResultScreen(),
        },
      ),
    );
  }
}
