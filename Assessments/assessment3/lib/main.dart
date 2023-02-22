import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cash_counter/screen/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/image_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cash Calculator",
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
            splash: Image(
              image: AssetImage(splashscreenImage),
            ),
            backgroundColor: Colors.black,
            splashIconSize: 150,
            duration: 2,
            animationDuration: const Duration(seconds: 2),
            splashTransition: SplashTransition.rotationTransition,
            nextScreen: DashBoardScreen()),
      ),
    );
  }
}
