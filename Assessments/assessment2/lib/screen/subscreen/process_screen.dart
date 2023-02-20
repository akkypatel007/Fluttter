import 'package:flutter/material.dart';

class ProccessScreen extends StatelessWidget {
  const ProccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List proccessList = [
      'New Driving License',
      'Addition of another category in the existing driving license',
      'Renewal of Driving License',
      'For change in details of driving license or obtaining a duplicate',
      'International Driving License or Permit',
      'Driving Licenses delivered'
    ];
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("How To Apply"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: proccessList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.autorenew_rounded),
                      title: Text(proccessList[index]),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
