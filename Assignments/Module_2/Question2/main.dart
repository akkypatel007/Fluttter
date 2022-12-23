import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  // int _counter = 0;
  var num1, num2;
  List<int> _number = [];
  void _incrementCounter() {
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      for (int i = num1 + 1; i < num2; i++) {
        _number += [i];
        // _number = [_counter];
      }
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
            Text(
              '$_number',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
