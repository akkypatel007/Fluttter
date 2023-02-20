//@dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imfaa/constants/images_string.dart';
import 'package:imfaa/constants/text_string.dart';
import 'package:imfaa/src/screen/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var isPasswordhidden = true.obs;
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Inventory App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 693,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xff1f005a),
                Color(0xff1b0063),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    const Image(
                      image: AssetImage(splashscreenImage),
                      height: 300,
                      width: 200,
                    ),
                    Positioned(
                      top: 230,
                      child: Text(
                        "Inventory",
                        style: GoogleFonts.allura(
                            textStyle: TextStyle(
                                fontSize: 58,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient)),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 250),
                        child: TextFormField(
                          // controller: _emailController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person_outline_outlined,
                              color: Colors.white,
                            ),
                            labelText: tEmail,
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: tEmail,
                            border: OutlineInputBorder(
                                gapPadding: 20,
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                )),
                            enabledBorder: OutlineInputBorder(
                                gapPadding: 20,
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                  width: 2.0,
                                )),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 250),
                          child: TextFormField(
                            // controller: _passwordController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  isPasswordhidden.value =
                                      !isPasswordhidden.value;
                                },
                                child: Icon(
                                  isPasswordhidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                              labelText: tPassword,
                              hintText: tPassword,
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                              /*border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                      width: 2.0,
                                    ))*/
                              enabledBorder: const OutlineInputBorder(
                                  gapPadding: 20,
                                  borderRadius: BorderRadius.all(Radius.zero),
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                              border: const OutlineInputBorder(
                                  gapPadding: 20,
                                  borderRadius: BorderRadius.all(Radius.zero),
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                    width: 2.0,
                                  )),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: isPasswordhidden.value,
                            onFieldSubmitted: (value) {},
                            validator: (value) {
                              // pass = value;
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

//Login Button
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen(),
                                    ));
                              },
                              child: Text(tLogin.toUpperCase()),
                            ),

                            //Forget Password
                            TextButton(
                                onPressed: () {},
                                child: const Text.rich(
                                  TextSpan(
                                      text: tForgetPassword,
                                      style: TextStyle(color: Colors.blue)),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
