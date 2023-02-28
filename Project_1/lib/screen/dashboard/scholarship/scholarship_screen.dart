import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../models/career_model.dart';

class ScholarshipScreen extends StatefulWidget {
  const ScholarshipScreen({Key? key}) : super(key: key);

  @override
  State<ScholarshipScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<ScholarshipScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Creer'),
      ),
      body: Column(
        children: [
          Container(),
          SingleChildScrollView(
            child: FutureBuilder<Welcome>(
              future: data(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.occupations.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(snapshot.data!.occupations[index]),
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
    );
  }
}
