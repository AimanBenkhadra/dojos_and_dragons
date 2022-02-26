import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';

import './screens/profile_screen.dart';
import './screens/qi_screen.dart';
import './screens/qi_charge_screen.dart';
import './model/adventurers.dart';
import './model/auth.dart';
import './model/skills.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        ),
        // home: ProfileScreen(),
        routes: {
          '/': (_) => ProfileScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
          QiScreen.routeName: (_) => QiScreen(),
          QiChargeScreen.routeName: (_) => QiChargeScreen(),
        },
      ),
    );
  }
}
