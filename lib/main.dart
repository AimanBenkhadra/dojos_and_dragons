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

  @override

  /// Root of the application.
  ///
  /// This is where it all starts
  Widget build(BuildContext context) {
    // First, we initiate all the Providers using the Provider package
    return MultiProvider(
      providers: [
        // I actually don't think I need to put this here, because this will be
        // replaced by the Auth Provider
        // Adventurer Provider
        // ChangeNotifierProvider(
        //   create: (_) => Adventurer(),
        // ),

        // For now, a single Adventurer does not interact with other Adventurers
        // and their actions don't affevt other Adventurers
        // Adventurers Provider
        // ChangeNotifierProvider(
        //   create: (_) => Adventurers(),
        // ),

        // Auth Provider
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),

        // Skills Provider
        ChangeNotifierProvider(
          create: (_) => Skills(),
        ),
      ],
      // Now, we build the app
      child: MaterialApp(
        // This is to remove the "debug" banner
        debugShowCheckedModeBanner: false,
        // Title of the app
        title: 'Doragons',
        // Theme of the app. I like orange.
        theme: ThemeData(
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
        ),
        // We use a StreamBuider to know which screen will be the home screen
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
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
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
