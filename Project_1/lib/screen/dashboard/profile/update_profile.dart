import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late User? user = FirebaseAuth.instance.currentUser;
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> userDataStream;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // final TextEditingController _controller = TextEditingController();

  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  String selctFile = '';
  late XFile file;
  late Uint8List selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;
  bool isItemSaved = false;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');
  String? imageUrl = '';

  Future<void> createUserInFirestore(User user) async {
    return await usersCollection.doc(user.uid).set({
      'email': user.email,
      'displayName': user.displayName,
      // Add any other user data you want to store in Firestore here
    });
  }

  @override
  void initState() {
    super.initState();
    initUserData();
  }

  void initUserData() {
    user = FirebaseAuth.instance.currentUser;
    userDataStream = FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(currentUser!.uid);
    // initUserData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                color: tDarkColor,
              )),
          title: Text('Edite Profile',
              style: Theme.of(context).textTheme.headline5),
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
            phoneController.text = userData?['phone'] ?? '';
            imageUrl = userData?['profile_pic'];

            // debugPrint(userData?['username']);
            // debugPrint(userData?['email']);
            // debugPrint(userData?['phone']);
            return SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: Column(
                    children: [
// -- IMAGE with ICON
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: imageUrl != null && imageUrl!.isNotEmpty
                                  ? Image.network(imageUrl!.toString())
                                  : const Icon(Icons.person, size: 80),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SafeArea(
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text('Gallery'),
                                              onTap: () {
                                                _getImage(ImageSource.gallery);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.camera_alt),
                                              title: const Text('Camera'),
                                              onTap: () {
                                                _getImage(ImageSource.camera);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: tPrimaryColor),
                                child: const Icon(LineAwesomeIcons.camera,
                                    color: Colors.black, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),

// -- Form Fields
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              // initialValue: userData?['name'] ?? "",
                              controller: nameController,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  hintText: userData?['username'],
                                  prefixIcon:
                                      const Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              // initialValue: userData?['email'] ?? "",
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: userData?['email'],
                                  prefixIcon:
                                      const Icon(LineAwesomeIcons.envelope_1)),
                            ),
                            const SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              // initialValue: userData?['phone'] ?? "",
                              controller: phoneController,
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: userData?['phone'],
                                  prefixIcon:
                                      const Icon(LineAwesomeIcons.phone)),
                            ),
                            const SizedBox(height: tFormHeight - 20),
/*
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: '******',
                                prefixIcon: const Icon(Icons.fingerprint),
                                suffixIcon: IconButton(
                                  icon: const Icon(LineAwesomeIcons.eye_slash),
                                  onPressed: () {},
                                ),
                              ),
                            ),
*/
                            const SizedBox(height: tFormHeight),
                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String phone = phoneController.text.trim();

                                  updateUser(name, email, phone);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: tPrimaryColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text('Edit Profile',
                                    style: TextStyle(color: tDarkColor)),
                              ),
                            ),
                            const SizedBox(height: tFormHeight),
                            // -- Created Date and Delete Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Joined   ',
                                    style: const TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                          text: userData?['joined_date'] ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text('Delete'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          },
        ));
  }

/*
  void updateUser(String name, String email, String phone) async {
    try {
      user = FirebaseAuth.instance.currentUser!;
      var url =
          Uri.parse('https://akkypatel007.000webhostapp.com/api/update2.php');
      var response = await https.post(
        url,
        body: {
          'id': user!.uid,
          'username': name,
          'email': email,
          'phone': phone,
          'profile_photo': '',
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"),
      );
      var data = jsonDecode(response.body);
      if (!data['error']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${data['message']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
*/

  void updateUser(String name, String email, String phone) async {
    try {
      /* var url =
          Uri.parse('https://akkypatel007.000webhostapp.com/api/update.php');
      var response = await https.post(
        url,
      body: {
          'id':u,
          'username': name,
          'email': email,
          'phone': phone,
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"),
      );
      var data = jsonDecode(response.body);
*/
      user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .update({
        'username': name,
        'email': email,
        'phone': phone,
      });
      /* if (!data['error']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${data['message']}'),
            backgroundColor: Colors.red,
          ),
        );
      }*/
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /*void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }*/

  Future<void> _getImage(ImageSource source) async {
    final String uid = user!.uid;
    final image = await ImagePicker().pickImage(
      source: source,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

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
}
