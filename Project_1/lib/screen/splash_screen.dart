import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'on_boarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLoading = false;

  SharedPreferences? logindata;
  bool? newuser;
  String? uname;
  String? pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // check_if_already_login();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreen())));
  }

  /*void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }*/

  // @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 3),
  //       () => Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => OnBoardingScreen())));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/animation/splash.json'),
    );
  }
}
