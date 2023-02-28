import 'package:flutter/material.dart';

import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import '../../widget/arc_text.dart';
import '../authentication_screen/login/loginscreen.dart';
import '../authentication_screen/signup/signup_screen.dart';

class SignupAndLogin extends StatefulWidget {
  const SignupAndLogin({Key? key}) : super(key: key);

  @override
  _SignupAndLoginState createState() => _SignupAndLoginState();
}

class _SignupAndLoginState extends State<SignupAndLogin>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: Container(
            // color: tPrimaryColor,
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    Image(
                      image: const AssetImage(tWelcomeScreenImage),
                      height: height * 0.4,
                    ),
                    const Positioned(
                      top: 80,
                      left: 90,
                      child: ArcText(
                        text: tSASSubTitle,
                        radius: 100,
                        startAngle: 79.2,
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        key: null,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      tSASTitle,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      tSASEndTitle,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(tLogin.toUpperCase()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(tSignup.toUpperCase()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
