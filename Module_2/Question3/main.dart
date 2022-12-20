import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calulator App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var num1, num2, finalans;
  int _rValue = 0;
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();

  void doAdding(int value) {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      finalans = num1 + num2;
    });
  }

  void doSubstract(int value) {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      finalans = num1 - num2;
    });
  }

  void doMultiplie(int value) {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      finalans = num1 * num2;
    });
  }

  void doDivide(int value) {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      finalans = num1 / num2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: t1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter Number 1"),
              ),
              TextFormField(
                controller: t2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter Number 2"),
              ),
              Padding(padding: EdgeInsets.all(20)),
              RadioListTile(
                  value: 1,
                  groupValue: _rValue,
                  title: Text('+', style: TextStyle(fontSize: 30)),
                  onChanged: (value) {
                    doAdding(value!);
                  }),
              RadioListTile(
                value: 2,
                groupValue: _rValue,
                title: Text('-', style: TextStyle(fontSize: 30)),
                onChanged: (value) {
                  doSubstract(value!);
                },
              ),
              RadioListTile(
                value: 3,
                groupValue: _rValue,
                title: Text('*', style: TextStyle(fontSize: 30)),
                onChanged: (value) {
                  doMultiplie(value!);
                },
              ),
              RadioListTile(
                value: 4,
                groupValue: _rValue,
                title: Text('/', style: TextStyle(fontSize: 30)),
                onChanged: (value) {
                  doDivide(value!);
                },
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                "Output is $finalans",
                style: TextStyle(color: Colors.green, fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
