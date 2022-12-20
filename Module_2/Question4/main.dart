//@dart=2.9

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*var background = [
    Colors.white,
    Colors.yellowAccent,
    Colors.pinkAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.amber
  ];*/
  var textSize = 20.0;
  bool click = true;
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      textSize = textSize + 1.0;
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      textSize = textSize - 1.0;
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Color change'),
        //leading: Icon(clicked == false)? Icons.favorite : Icons.table_chart,
      ),
      backgroundColor: (click == false) ? Colors.amber : Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: textSize),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  click = !click;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Icon(
                  (click == true) ? Icons.favorite : Icons.table_chart,
                  size: 40,
                ),
              ),
            ),
            Text(
              'tap-Icon for Change background color',
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 0),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 40),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
