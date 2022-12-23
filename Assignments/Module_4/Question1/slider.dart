//@dart=2.9
import 'package:flutter/material.dart';
import 'package:splash_screen_project/splash_screen.dart';

class slide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Splash Screen"),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ));
            },
            child: Container(
              color: Colors.amber,
              child: Text('Spals Screen'),
            ),
          ),
        ));
  }
}
