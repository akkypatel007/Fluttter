import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == 10) {
        showDialog;
      }
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('AlertDialog Title'),
            content: Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            icon: Icon(Icons.access_alarm_rounded),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _incrementCounter,
                child: const Text('OK'),
              ),
            ],
          ),
        ),

        // child: const Text('Show Dialog'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  AlertDialog1(
      {String title = "Are you sure",
      String description = "Do you want to increase "}) {
    Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Get.textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.text_increase_rounded),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Okay"),
            ),
          ],
        ),
      ),
    );
  }
}
