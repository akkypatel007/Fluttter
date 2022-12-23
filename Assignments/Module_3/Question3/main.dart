import 'package:flutter/material.dart';

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
    });
  }

  void _refresh() {
    setState(() {
      _counter = 0;
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
            ElevatedButton(
                onPressed: () => ShowDialog(context), child: Text('edit'))
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

  void ShowDialog(BuildContext context) {
    Widget Button1 = TextButton(
        onPressed: () {
          _refresh();
          Navigator.of(context).pop();
        },
        child: Text("Yes"));

    Widget Button2 = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("No"));

    Widget Button3 = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Cancel"));

    AlertDialog box = AlertDialog(
      title: Text("Are You Sure To edit"),
      content: Text("it refresh"),
      actions: [Button1, Button2, Button3],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return box;
        });
  }
}

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
