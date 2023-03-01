import 'dart:convert';

import 'package:career360/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../models/all_jobs_alert.dart';

class ExamsScreen extends StatefulWidget {
  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<ExamsScreen> {
  late Future<List<AllStateJobsAlert>> _futureJobs;

  @override
  void initState() {
    super.initState();
    _futureJobs = fetchJobs();
  }

  Future<List<AllStateJobsAlert>> fetchJobs() async {
    final response = await http.get(Uri.parse(
        'https://akkypatel007.000webhostapp.com/allstatejobalert.json'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((job) => AllStateJobsAlert.fromJson(job))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
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
          'Exams & Jobs',
          style: TextStyle(color: tDarkColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
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
                hintText: 'Search Exams',
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
              child: Center(
                child: FutureBuilder<List<AllStateJobsAlert>>(
                  future: _futureJobs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final jobs = snapshot.data!;
                      final filteredJobs = jobs
                          .where((job) => job.name
                              .toLowerCase()
                              .contains(searchcontroller.text.toLowerCase()))
                          .toList();
                      return ListView.builder(
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = filteredJobs[index];
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
                                        image: AssetImage(tLogoExam),
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
                                              BorderRadius.circular(50),
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
                                              width: 2,
                                            ),
                                            Text(
                                              'Job Alerts',
                                              style: TextStyle(
                                                fontSize: 6,
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
                                        job.name ?? "",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          const Icon(
                                            Icons.link,
                                            color: Colors.blue,
                                            size: 12,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                launchUrl(Uri.parse(job.link));
                                              },
                                              child: Text(
                                                job.link ?? "",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
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
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
