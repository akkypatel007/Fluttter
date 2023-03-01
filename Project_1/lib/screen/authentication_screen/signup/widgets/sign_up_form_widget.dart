import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../login/loginscreen.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  final CollectionReference _addUserdata =
      FirebaseFirestore.instance.collection("user");

  bool isLoading = false;

  String? name, email, phone, pass;
  String formattedDate = DateFormat.yMMMd().format(DateTime.now());

  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //password visibilty
  var ispasswordhidden = true.obs;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "",
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                label: Text(tFullName),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                      width: 2.0,
                    )),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              // onSaved: (value) {
              //   name = value;
              // },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text(tEmail),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                      width: 2.0,
                    )),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              // onSaved: (value) {
              //   email = value;
              // },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _phoneNoController,
              // onChanged: (value) {
              //   setState(() {
              //     controller.phoneNo.text = value;
              //   });
              // },
              decoration: InputDecoration(
                label: const Text(tPhoneNo),
                prefixIcon: Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme:
                              CountryListThemeData(bottomSheetHeight: 550),
                          onSelect: (value) {
                            setState(() {
                              selectedCountry = value;
                            });
                          });
                    },
                    child: Text(
                      "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                suffixIcon: _phoneNoController.text.length > 9
                    ? Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                      width: 2.0,
                    )),
              ),

              // onSaved: (value) {
              //   phone = value;
              // },
            ),
            /*IntlPhoneField(
              controller: controller.phoneNo,
              decoration: InputDecoration(
                label: const Text(tPhoneNo),
                suffixIcon: controller.phoneNo.text.length > 9
                    ? Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(
                      width: 2.0,
                    )),
              ),
              onChanged: (value) {
                print(value.completeNumber);
              },
              initialCountryCode: 'IN',

            ),*/
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: _passwordController,
                obscureText: ispasswordhidden.value,
                decoration: InputDecoration(
                  label: const Text(tPassword),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                      )),
                  prefixIcon: const Icon(Icons.fingerprint),
                  suffixIcon: InkWell(
                    onTap: () {
                      ispasswordhidden.value = !ispasswordhidden.value;
                    },
                    child: Icon(ispasswordhidden.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
                // onSaved: (value) {
                //   pass = value;
                // },
/*
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Password";
                  } else if (value.length < 6) {
                    return "Please Enter as long as password";
                  }
                },
*/
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isLoading) {
                    return;
                  }
                  if (_fullNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Please Enter Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.yellowAccent,
                    ));

                    // scaffoldMessenger.showSnackBar(
                    //     SnackBar(content: Text("Please Enter Name")));
                    return;
                  }
                  if (!reg.hasMatch(_emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Enter Valid Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.yellowAccent,
                    ));
                    // scaffoldMessenger.showSnackBar(
                    //     SnackBar(content: Text("Enter Valid Email")));
                    return;
                  }
                  if (_phoneNoController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Please Enter Phone number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.yellowAccent,
                    ));

                    // scaffoldMessenger.showSnackBar(
                    //     SnackBar(content: Text("Please Enter Phone number")));
                    return;
                  }
                  if (_passwordController.text.isEmpty ||
                      _passwordController.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Password should be min 6 characters",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.yellowAccent,
                    ));

                    // scaffoldMessenger.showSnackBar(SnackBar(
                    //     content: Text("Password should be min 6 characters")));
                    return;
                  }

                  signup(_fullNameController.text, _emailController.text,
                      _phoneNoController.text, _passwordController.text);
                  debugPrint('_______======+++++$formattedDate');
                },
                child: Text(tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');

  Future<void> createUserInFirestore(User user) async {
    return await usersCollection.doc(user.uid).set({
      'email': user.email,
      'username': user.displayName,
      'phone': user.displayName,
      'pass': user.displayName,
      'profile_photo': user.displayName,
      'joined_date': user.displayName,
      // Add any other user data you want to store in Firestore here
    });
  }

/*  Future<Map<String, dynamic>> addUser(String username, String email,
      String phone, String password, String profileImage) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
        Uri.parse('https://akkypatel007.000webhostapp.com/api/insert.php'),
        body: {
          'username': username,
          'email': email,
          'phone': phone,
          'pass': password,
          'profile_photo': profileImage
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      try {
        UserCredential authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User user = authResult.user;
        await createUserInFirestore(user);
        await usersCollection.doc(user.uid).update({
          'username': username,
          'phone': phone,
          'profile_photo': profileImage
        });
        Map<String, dynamic> responseData = {
          'status': 'success',
          'message': 'User added successfully'
        };
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
        return responseData;
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        throw Exception(error.toString());
      }
    }
  }*/
  Future<Map<String, dynamic>> addUser(String username, String email,
      String phone, String password, String profileImage) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
        Uri.parse('https://akkypatel007.000webhostapp.com/api/insert.php'),
        body: {
          'username': username,
          'email': email,
          'phone': phone,
          'pass': password,
          'profile_photo': profileImage
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);
      UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      await createUserInFirestore(user!);
      // Upload the profile photo to Firebase Storage
      String downloadUrl = '';
      if (profileImage.isNotEmpty) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(user.uid);
        await ref.putFile(File(profileImage));
        downloadUrl = await ref.getDownloadURL();
      }
      await usersCollection.doc(user.uid).update({
        'username': username,
        'phone': phone,
        'profile_photo': downloadUrl ?? "",
        'joined_date': formattedDate.toString(),
      });

      Map<String, dynamic> resposne = json.decode(response.body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
      return resposne;
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to add user');
    }
  }

  void signup(name, email, phone, password) async {
    setState(() {
      isLoading = true;
    });
    print("++++++++++++++Calling");
    final response = await addUser(name, email, phone, password, '');
    print(response);

    if (response is int && response == 0) {
      print("User data is missing");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else if (response is Map<String, dynamic>) {
      if (response['error']) {
        print("User name ${response['data']}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      } else if (response['message'] != null) {
        print(response['message']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "${response['message']}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.black,
        ));
      } else {
        print("Unknown response format: $response");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Please Try again",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
        ));
      }
    } else if (response is String) {
      // If response is a JSON-encoded string, decode it and check for the 'error' key

    }
  }
}
