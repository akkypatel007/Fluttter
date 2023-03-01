import 'dart:convert';

import 'package:career360/screen/dashboard/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../forget_password/foget_password_option/foget_password_model_bottom_sheet.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ScaffoldMessengerState? scaffoldMessenger;
  SharedPreferences? logindata;

  var isPasswordhidden = true.obs;
  var isLoading = false;

  final textFieldFocusNode = FocusNode();

  Future login() async {
    var url = "https://akkypatel007.000webhostapp.com/api/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": _emailController.text,
      "pass": _passwordController.text,
    });
    var data = json.decode(response.body);

    /*try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      final ex = FirebaseAuthException(code: e.code);
      return ex.message;
    } catch (_) {
      const ex = FirebaseAuth.instance.printError(logFunction: ex.);
      return ex.message;
    }
    return null;*/
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());

    if (data == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Please Enter valid detail",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
      ));
      print("fail2");
    } else {
      String _email = _emailController.text;
      String password = _passwordController.text;

      if (_email != "" && password != "") {
        print("success2");
        print(_email);
        print(password);
        logindata?.setBool('login', false);
        logindata?.setString('username', _email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // check_if_already_login();
  }

  bool? newuser;
  String? pass;

/*
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
  }
*/

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                      width: 2.0,
                    )),
              ),
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {},
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)) {
                  return 'Enter valid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: tFormHeight - 20,
            ),
            Obx(
              () => TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: InkWell(
                      onTap: () {
                        isPasswordhidden.value = !isPasswordhidden.value;
                      },
                      child: Icon(
                        isPasswordhidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    labelText: tPassword,
                    hintText: tPassword,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          width: 2.0,
                        ))),
                keyboardType: TextInputType.text,
                obscureText: isPasswordhidden.value,
                onFieldSubmitted: (value) {},
                validator: (value) {
                  pass = value;
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: tFormHeight - 20,
            ),

            //Forget Password
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      ForgetPasswordScreen.buildShowModalBottomSheet(context);
                    },
                    child: const Text.rich(
                      TextSpan(
                          text: tForgetPassword,
                          style: TextStyle(color: Colors.blue)),
                    ))),
//Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => login(),
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
