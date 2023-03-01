import 'dart:convert';

import 'package:career360/constants/colors.dart';
import 'package:career360/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class College {
  final String university;
  final String college;
  final String collegeType;
  final String state;
  final String district;

  College({
    required this.university,
    required this.college,
    required this.collegeType,
    required this.state,
    required this.district,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      university: json['university'],
      college: json['college'],
      collegeType: json['college_type'],
      state: json['state'],
      district: json['district'],
    );
  }
}

class CollegeScreen extends StatefulWidget {
  const CollegeScreen({Key? key}) : super(key: key);

  @override
  State<CollegeScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CollegeScreen> {
  late Future<List<College>> _futureColleges;

  @override
  void initState() {
    super.initState();
    _futureColleges = _fetchColleges();
  }

  Future<List<College>> _fetchColleges() async {
    final response = await http
        .get(Uri.parse('https://akkypatel007.000webhostapp.com/colleges.json'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<College> collegeList =
          jsonList.map((json) => College.fromJson(json)).toList();
      print('+++++++++++++${collegeList.length}');
      return collegeList;
    } else {
      throw Exception('Failed to fetch colleges');
    }
  }

  String? search = '';
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: tDarkColor,
            )),
        title: const Text(
          'College',
          style: TextStyle(color: tDarkColor),
        ),
      ),
      body: Column(
        children: [
          TextField(
            autofocus: false,
            controller: searchcontroller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              // fillColor: Colors.grey[300],
              // filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Search other College',
              hintStyle: const TextStyle(color: Colors.grey),
              suffix: const Icon(Icons.search),
            ),
            onChanged: (String? value) {
              setState(() {
                search = value.toString();
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<College>>(
              future: _futureColleges,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final colleges = snapshot.data!;

                  // Filter colleges based on the search text
                  final filteredColleges = colleges
                      .where((college) =>
                          college.college
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase()) ||
                          college.state
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase()) ||
                          college.district
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase()) ||
                          college.university
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase()))
                      .toList();

                  // Display filtered colleges
                  return ListView.builder(
                    itemCount: filteredColleges.length,
                    itemBuilder: (context, index) {
                      final college = filteredColleges[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Image(
                                    image: AssetImage(tLogoCollege),
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 16,
                                    width: 46,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      children: const [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'private',
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 250,
                                child: ListTile(
                                  title: Text(
                                    college.college ?? "",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.blue,
                                        size: 12,
                                      ),
                                      Text(
                                        college.state ?? "",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
/*
          Expanded(
            child: FutureBuilder<List<College>>(
              future: _futureColleges,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final colleges = snapshot.data!;

                  final filteredColleges = colleges
                      .where((college) => college.college
                          .toLowerCase()
                          .contains(searchcontroller.text.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: filteredColleges.length,
                    itemBuilder: (context, index) {
                      final college = colleges[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  Image(
                                    image: AssetImage(tLogoCollege),
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 16,
                                    width: 46,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.circle_rounded,
                                            size: 8, color: Colors.white),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'private',
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: 250,
                                  child: ListTile(
                                    title: Text(
                                      college.college ?? "",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.blue,
                                          size: 12,
                                        ),
                                        Text(college.state ?? "",
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
*/
        ],
      ),
    );
  }
}
