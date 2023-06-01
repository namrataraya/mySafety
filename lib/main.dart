import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_safety/screens/home_page.dart';
import 'package:provider/provider.dart';

//my imports
import './helpers/colors.dart';
import './screens/welcome.dart';
import './providers/providers_list.dart';

var isLoggedIn;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await Geolocator.openLocationSettings();
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  Widget? firstWidget;

  @override
  Widget build(BuildContext context) {
    if (firebaseUser != null) {
      firstWidget = HomePage();
    } else {
      firstWidget = Welcome();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF03A69A),
          iconTheme: IconThemeData(
            color: subtitle_color,
            size: 28,
          )),
      home: firstWidget,
    );
  }
}
