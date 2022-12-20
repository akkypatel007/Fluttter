//@dart=2.9

import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reverse number',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;

  // TextEditingController result = TextEditingController();
  TextEditingController _numcontroller = TextEditingController();
  int r, reverse = 0, reminder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBar"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: _numcontroller,
                decoration: InputDecoration(
                  labelText: "Enter number",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            ),
            SizedBox(height: 30),
            AnimatedContainer(
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(border: Border.all(width: 9)),
                padding: EdgeInsets.all(20),
                child: TextButton(
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: "Show Reult\n",
                          style: TextStyle(color: Colors.green)),
                      TextSpan(
                          text: "$result",
                          style: TextStyle(color: Colors.limeAccent[300]))
                    ],
                  )),
                  onPressed: () {
                    setState(() {
                      int r = int.parse(_numcontroller.text);
                      int reverse = 0, reminder;

                      while (r != 0) {
                        reminder = r % 10;
                        reverse = reverse * 10 + reminder;
                        r ~/= 10;
                      }
                      result = reverse;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
