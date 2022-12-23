//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TwoNumber());
}

class TwoNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Display Sum",
      debugShowCheckedModeBanner: false,
      home: Secondpage(),
    );
  }
}

class Secondpage extends StatefulWidget {
  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sum"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: "First Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {},
              controller: number1,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Second Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {},
              controller: number2,
            ),
            ElevatedButton(
                onPressed: () {
                  var n1 = int.parse(number1.text);
                  var n2 = int.parse(number2.text);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ShowSum(n1, n2)));
                },
                child: Text("Sum"))
          ],
        ),
      ),
    );
  }
}

class ShowSum extends StatefulWidget {
  int n1, n2;
  ShowSum(this.n1, this.n2);

  @override
  State<ShowSum> createState() => _ShowSumState(n1, n2);
}

class _ShowSumState extends State<ShowSum> {
  int num1, num2;
  _ShowSumState(this.num1, this.num2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sum"),
      ),
      body: Center(
        child: Text("Sum of Those two number is ${[num1 + num2]}"),
      ),
    );
  }
}
