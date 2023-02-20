import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  List<String> _statasticList = [
    'Driving Licence',
    'Vehicle Population',
    'Road Accidents'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Statistics"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(),
          itemCount: _statasticList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset(
                'assets/piechart.png',
                height: 40,
                width: 40,
              ),
              title: Text(_statasticList[index]),
            );
          },
        ),
      ),
    );
  }
}
