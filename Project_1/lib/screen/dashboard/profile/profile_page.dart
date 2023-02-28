import 'dart:io';

import 'package:career360/constants/colors.dart';
import 'package:career360/constants/sizes.dart';
import 'package:career360/screen/authentication_screen/login/loginscreen.dart';
import 'package:career360/screen/dashboard/profile/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SharedPreferences? logindata;
  String? username;
  late User? user = FirebaseAuth.instance.currentUser;
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> userDataStream;
  late final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? imageUrl = '';

  @override
  void initState() {
    super.initState();
    initial();
    initUserData();
  }

  void initUserData() {
    user = FirebaseAuth.instance.currentUser;
    userDataStream = FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .snapshots();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata?.getString('username')!;
    });
  }

  void pickUploadImage() async {
    final String uid = user!.uid;
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);

    Reference storageReference =
        FirebaseStorage.instance.ref().child('users/$uid/profilepic.jpg');
    await storageReference.putFile(File(image!.path));

    String imageUrl = await storageReference.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'profile_pic': imageUrl});

    setState(() {
      // Update the UI with the new image URL
      imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              LineAwesomeIcons.angle_left,
              color: tDarkColor,
            )),
        title: Text('Profile', style: Theme.of(context).textTheme.headline5),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: tDarkColor,
              ))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userDataStream,
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          // Access the user's data from the DocumentSnapshot
          Map<String, dynamic>? userData = snapshot.data?.data();

          // Set the values of the text fields to the user's data
          nameController.text = userData?['username'] ?? '';
          emailController.text = userData?['email'] ?? '';
          imageUrl = userData?['profile_pic'] ?? "";
          // debugPrint(userData?['username']);
          // debugPrint(userData?['email']);
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: imageUrl != null && imageUrl!.isNotEmpty
                              ? Image.network(imageUrl!.toString())
                              : Icon(Icons.person, size: 80),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            pickUploadImage();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: tPrimaryColor),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(userData?['username'] ?? '',
                      style: Theme.of(context).textTheme.headline5),
                  Text(userData?['email'] ?? '',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(),
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        "Edite Profile",
                        style: TextStyle(color: tDarkColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                    title: 'Settings',
                    icon: LineAwesomeIcons.cog,
                    onPressed: () {},
                  ),
                  ProfileMenuWidget(
                    title: 'personal Detail',
                    icon: LineAwesomeIcons.user,
                    onPressed: () {},
                  ),
                  ProfileMenuWidget(
                    title: 'User Managements',
                    icon: LineAwesomeIcons.user_check,
                    onPressed: () {},
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfileMenuWidget(
                    title: 'Information',
                    icon: LineAwesomeIcons.info,
                    onPressed: () {},
                  ),
                  ProfileMenuWidget(
                    title: 'Logout',
                    icon: LineAwesomeIcons.alternate_sign_out,
                    endIcon: false,
                    textColor: Colors.red,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      logindata?.setBool('login', false);
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: tAccentColor.withOpacity(0.1)),
        child: Icon(
          icon,
          // LineAwesomeIcons.cog,
          color: tAccentColor,
        ),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText2?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
                color: tAccentColor,
              ),
            )
          : null,
    );
  }
}
