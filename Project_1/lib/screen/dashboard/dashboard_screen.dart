import 'package:career360/constants/colors.dart';
import 'package:career360/screen/dashboard/career/CareerScreen.dart';
import 'package:career360/screen/dashboard/scholarship/scholarship_screen.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/image_strings.dart';
import 'college/college_screen.dart';
import 'exam/exams_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late User? user = FirebaseAuth.instance.currentUser;
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> userDataStream;

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

  String _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 18) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  final List<Widget> images = [
    Image.asset(tSliderImage1),
    Image.asset(tSliderImage2),
    Image.asset(tSliderImage3),
    Image.asset(tSliderImage4),
    Image.asset(tSliderImage5),
    Image.asset(tSliderImage6),
  ];
  final List<Map<String, dynamic>> careerList = [
    {'name': 'Career', 'image': tLogoCareer, 'navigate': CareerScreen()},
    {
      'name': 'Scholarship',
      'image': tLogoScholarship,
      'navigate': ScholarshipScreen()
    },
    {'name': 'College', 'image': tLogoCollege, 'navigate': CollegeScreen()},
    {'name': 'Exam', 'image': tLogoExam, 'navigate': ExamsScreen()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              )),
          centerTitle: true,
          title: Text(
            'Career 360',
            style: TextStyle(color: tDarkColor),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.lightbulb,
                  color: Colors.grey,
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
            Map<String, dynamic>? userData = snapshot.data?.data();
            var name = userData?['username'] ?? '';

            return SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _greeting(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${name} ☺️',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      ),
                      const SizedBox(height: 12),
                      CarouselSlider(
                        items: images,
                        options: CarouselOptions(
                          height: 200,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('Explore'),
                      const SizedBox(height: 14),
                      Container(
                        height: 240,
                        child: GridView.builder(
                          itemCount: careerList.length, // number of grid items
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.8),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            careerList[index]['navigate']));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 120,
                                    width: 165,
                                    decoration: BoxDecoration(
                                        // color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey)),
                                    child: Align(
                                      alignment: Alignment(0.5, 0.5),
                                      child: Text(
                                        careerList[index]['name'],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child:
                                        Image.asset(careerList[index]['image']),
                                    height: 48,
                                    width: 48,
                                    top: 0,
                                    left: 15,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            );
          },
        ));
  }
}
