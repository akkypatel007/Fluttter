import 'package:career360/constants/colors.dart';
import 'package:career360/screen/dashboard/profile/give_us_feedback.dart';
import 'package:career360/screen/dashboard/profile/my_assessment_reports.dart';
import 'package:career360/screen/dashboard/profile/my_packages.dart';
import 'package:career360/screen/dashboard/profile/my_queries.dart';
import 'package:career360/screen/dashboard/profile/profile_page.dart';
import 'package:career360/screen/dashboard/profile/refers_and_earn.dart';
import 'package:career360/screen/dashboard/profile/scan_qr_code.dart';
import 'package:career360/screen/dashboard/profile/terms_of_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> options = [
    {
      'name': 'profile',
      'choices': [
        'profile',
        'My Packages',
        'My Assessment Reports',
        'My Queries',
      ],
      'icons': [
        const Icon(Icons.person_outline),
        const Icon(CupertinoIcons.cube_box),
        const Icon(CupertinoIcons.doc_chart),
        const Icon(Icons.question_mark_outlined),
      ],
      'navigate': [
        const ProfilePage(),
        const MyPackages(),
        const MyAssessmentReports(),
        const MyQuearies()
      ],
    },
    {
      'name': 'refer',
      'choices': [
        'Scan QR Code',
        'Refer & Earn',
      ],
      'icons': [
        const Icon(Icons.qr_code_scanner),
        const Icon(Icons.attach_money_rounded),
      ],
      'navigate': [const ScanQRcode(), const RefersAndEarn()],
    },
    {
      'name': 'services',
      'choices': ['Terms of Services', 'Give us Feedback'],
      'icons': [
        const Icon(CupertinoIcons.doc_text),
        const Icon(CupertinoIcons.person_2),
      ],
      'navigate': [const TermsOfServices(), const GiveUsFeedBack()],
    },
  ];
  var name;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(name ?? "hello dear",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
              _buildChoice(0),
              const Center(
                child: SizedBox(
                  width: 180,
                  child: DividerTheme(
                      data: DividerThemeData(space: 8),
                      child: Divider(
                        thickness: 1.5,
                      )),
                ),
              ),
              _buildChoice(1),
              const Center(
                child: SizedBox(
                  width: 180,
                  child: DividerTheme(
                      data: DividerThemeData(space: 8),
                      child: Divider(
                        thickness: 1.5,
                      )),
                ),
              ),
              _buildChoice(2),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildChoice(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List<Widget>.generate(options[index]['choices'].length,
                (int choiceIndex) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: InkWell(
                  onTap: () async {
                    var value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                options[index]['navigate'][choiceIndex]));
                    setState(() {
                      name = value;
                    });
                  },
                  child: ListTile(
                    iconColor: tDarkColor,
                    leading: options[index]['icons'][choiceIndex],
                    title: Text(
                      options[index]['choices'][choiceIndex],
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
