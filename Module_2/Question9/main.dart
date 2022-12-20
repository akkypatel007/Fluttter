//@dart=2.9
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
      home: MyHomePage(title: 'Module-2,Question-9'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SingingCharacter {
  yellowAccent,
  greenAccent,
  amberAccent,
  cyanAccent,
  orangeAccent
}

class _MyHomePageState extends State<MyHomePage> {
  SingingCharacter _character = SingingCharacter.yellowAccent;
  int _counter = 0;
  Color colors = Colors.limeAccent;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Container(
        color: colors,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RadioListTile(
              title: Text('YellowAccent'),
              value: SingingCharacter.yellowAccent,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  colors = Colors.yellowAccent;
                  _character = value;
                });
              },
            ),
            RadioListTile(
              title: Text('GreenAccent'),
              value: SingingCharacter.greenAccent,
              groupValue: _character,
              activeColor: Colors.black,
              onChanged: (SingingCharacter value) {
                setState(() {
                  colors = Colors.greenAccent;
                  _character = value;
                });
              },
            ),
            RadioListTile(
              title: Text('AmberAccent'),
              value: SingingCharacter.amberAccent,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  colors = Colors.amberAccent;
                  _character = value;
                });
              },
            ),
            RadioListTile(
              title: Text('CyanAccent'),
              value: SingingCharacter.cyanAccent,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  colors = Colors.cyanAccent;
                  _character = value;
                });
              },
            ),
            RadioListTile(
              title: Text('OrangeAccent'),
              value: SingingCharacter.orangeAccent,
              activeColor: Colors.black,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  colors = Colors.orangeAccent;
                  _character = value;
                });
              },
            ),
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
