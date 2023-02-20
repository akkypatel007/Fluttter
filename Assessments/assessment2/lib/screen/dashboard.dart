import 'package:flutter/material.dart';
import 'package:rto_app/const/images.dart';
import 'package:rto_app/screen/quizApp.dart';
import 'package:rto_app/screen/subscreen/faq_screen.dart';
import 'package:rto_app/screen/subscreen/form_screen.dart';
import 'package:rto_app/screen/subscreen/learnscreen.dart';
import 'package:rto_app/screen/subscreen/office_screen.dart';
import 'package:rto_app/screen/subscreen/practice_screen.dart';
import 'package:rto_app/screen/subscreen/process_screen.dart';
import 'package:rto_app/screen/subscreen/revision_screen.dart';
import 'package:rto_app/screen/subscreen/statics_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    List<Map<String, dynamic>> dItems = [
      {"id": 1, "image": learn, "name": "Learn"},
      {"id": 2, "image": practice, "name": "Practice"},
      {"id": 3, "image": mocktest, "name": "Moke Test"},
      {"id": 4, "image": revision, "name": "Marked For \nRevision"},
      {"id": 5, "image": office, "name": "Office"},
      {"id": 6, "image": process, "name": "process"},
      {"id": 7, "image": chart, "name": "Statistics"},
      {"id": 8, "image": form, "name": "Forms"},
      {"id": 8, "image": faq, "name": "FAQ"},
    ];
    List pages = [
      QuestionList(),
      PracticeScreen(),
      QuizApp(),
      RevisionScreen(),
      OfficeScreen(),
      ProccessScreen(),
      StatisticsScreen(),
      FormScreen(),
      FaqScreen(),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("RTO Driving Licence Test"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemCount: dItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (itemWidth / itemHeight)),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index],
                          ));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            dItems[index]["image"],
                            width: 75,
                            height: 70,
                          ),
                          SizedBox(height: 10),
                          Text(dItems[index]["name"])
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
