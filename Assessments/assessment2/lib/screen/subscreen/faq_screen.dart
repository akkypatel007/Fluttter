import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> faqList = [
      "Learning Licence",
      "Driving Licence",
      "Registration of Vehicle",
      "Fitness of Vehicle",
      "Permit",
      "PUC"
    ];
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("F&Q"),
          centerTitle: true,
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: faqList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.question_mark_rounded),
                    ),
                    title: Text(faqList[index]),
                  ),
                ),
              );
            }));
  }
}
