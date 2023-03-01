import 'package:career360/constants/colors.dart';
import 'package:career360/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../models/career_model.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({Key? key}) : super(key: key);

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  // Assume that your JSON file is included in your app's assets as `assets/data.json`

// Define your Welcome model class here (same as in your question)

  Future<Welcome> data() async {
    // Read the contents of the JSON file using rootBundle
    // Read the contents of the JSON file using rootBundle
    final contents = await rootBundle.loadString('assets/json/jobs.json');

    // Parse the JSON contents into a Welcome object using your model class
    final welcome = welcomeFromJson(contents);

    return welcome;
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
        title: Text(
          'Creer',
          style: TextStyle(color: tDarkColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 5),
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
                hintText: 'Search other Career',
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
              child: FutureBuilder<Welcome>(
                future: data(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    final occupations = snapshot.data!.occupations;
                    final filteredOccupations = occupations
                        .where((occupation) => occupation
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase()))
                        .toList();
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.8,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: filteredOccupations.length,
                      itemBuilder: (context, index) {
                        // use modulo to cycle through icons
                        return Container(
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(tLogoCareer),
                                height: 45,
                                width: 45,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(filteredOccupations[index]),
                                  ),
                                ),
                              ),

                              // Expanded(
                              //   child: Marquee(
                              //     text: filteredOccupations[index],
                              //     // fadingEdgeStartFraction: 0.2,
                              //     // fadingEdgeEndFraction: 0.2,
                              //     blankSpace: kTextTabBarHeight,
                              //     numberOfRounds: 1,
                              //     // showFadingOnlyWhenScrolling: true,
                              //     pauseAfterRound: Duration(minutes: 1),
                              //     showFadingOnlyWhenScrolling: true,
                              //     scrollAxis: Axis.horizontal,
                              //   ),
                              // ),

                              /* AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 500),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                child: Center(
                                  child: Text(filteredOccupations[index]),
                                ),
                              ),*/
                              /*AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: 1.0,
                                curve: Curves.easeInOut,
                                child: Center(
                                  child: Text(filteredOccupations[index]),
                                ),
                              )*/

                              /*TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 500),
                                builder: (BuildContext context, double value,
                                    Widget? child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Center(
                                      child: Text(filteredOccupations[index]),
                                    ),
                                  );
                                },
                              )*/
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<IconData> icons = [
    Icons.person,
    Icons.engineering,
    Icons.school,
    Icons.accessibility_sharp,
  ];
}
