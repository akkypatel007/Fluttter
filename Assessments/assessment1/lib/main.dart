//@dart=2.9
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:imfaa/constants/images_string.dart';
import 'package:imfaa/src/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'INVENTORY MANAGEMENT FLUTTER APP',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
            splash: const Image(
              image: AssetImage(splashscreenImage),
            ),
            backgroundColor: Colors.black,
            splashIconSize: 150,
            duration: 2,
            animationDuration: const Duration(seconds: 2),
            splashTransition: SplashTransition.rotationTransition,
            nextScreen: const LoginScreen()),
      ),
    );
  }
}
