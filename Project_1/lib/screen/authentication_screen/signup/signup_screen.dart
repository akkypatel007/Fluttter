import 'package:career360/screen/authentication_screen/signup/widgets/sign_up_form_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common_widget/form/form_header_widget.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../login/loginscreen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const FormHeaderWidget(
                  image: tSignUpScreenImage,
                  title: tSignUpTitle,
                  subtitle: tSignUpSubTitle,
                ),
                SignUpFormWidget(),
                Column(
                  children: [
                    const Text("OR"),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Image(
                          image: AssetImage(tGoogleLogoImage),
                          width: 20.0,
                        ),
                        label: Text(tSignInWithGoogle.toUpperCase()),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: tAlreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyText1),
                          TextSpan(
                              text: tLogin.toUpperCase(),
                              style: TextStyle(color: Colors.blue)),
                        ]),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
