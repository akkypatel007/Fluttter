import 'package:career360/constants/colors.dart';
import 'package:career360/screen/welcome_screen/signup_and_login.dart';
import 'package:flutter/material.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';

class WelocmePage extends StatefulWidget {
  const WelocmePage({Key? key}) : super(key: key);

  @override
  State<WelocmePage> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelocmePage> {
  List<Map<String, dynamic>> options = [
    {
      'name': 'School',
      'choices': [
        'class7',
        'class8',
        'class9',
        'class10',
        'class11',
        'class12',
      ],
    },
    {
      'name': 'Higher Education',
      'choices': [
        'Bachelor\'s',
        'Master\'s',
        'Doctoral',
      ],
    },
    {
      'name': 'Working',
      'choices': ['Professional', 'Entrepreneur'],
    },
    {
      'name': 'Options',
      'choices': ['Educator', 'Employer'],
    },
  ];

  String? selectedCategory;
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: tCardBgColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 15, top: 20),
          child: Column(
            children: [
              Container(
                height: height * 3 / 3.7,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        '(Select one)',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.red),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              tWelcomeTitle,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  tWelcomeSubTitle,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Image.asset(
                                  tWelcomeScreenImage1,
                                  height: 60,
                                  width: 60,
                                ),
                              ],
                            ),
                            _buildSingleChoiceButton(0),
                            _buildSingleChoiceButton(1),
                            _buildSingleChoiceButton(2),
                            const Text(
                              tWelcomeEndTitle,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  tWelcomeSubTitle,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Image.asset(
                                  tWelcomeScreenImage2,
                                  height: 60,
                                  width: 60,
                                ),
                              ],
                            ),
                            _buildSingleChoiceButton(3),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  selectedCategory != null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupAndLogin(),
                          ),
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a category'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0)),
                child: Container(
                  height: height * 4 / 55,
                  width: width * 3 / 7,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                      child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 25),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingleChoiceButton(int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              options[index]['name'],
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF00AAEA),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: List<Widget>.generate(
                options[index]['choices'].length,
                (int choiceIndex) {
                  return ChoiceChip(
                    backgroundColor: kGrey,
                    selectedColor: Colors.cyanAccent,
                    label: Text(options[index]['choices'][choiceIndex]),
                    selected: selectedCategory == options[index]['name'] &&
                        selectedOption ==
                            options[index]['choices'][choiceIndex],
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedCategory = options[index]['name'];
                          selectedOption =
                              options[index]['choices'][choiceIndex];
                        } else {
                          selectedCategory = null;
                          selectedOption = null;
                        }
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ],
        ));
  }
}
