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
  TextEditingController chargesMaxController = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  int _counter = 0;
  bool one = false;
  bool priceupdate_value = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    chargesMaxController.addListener(() {
      if (one) {
        setState(() {
          controller1.text = chargesMaxController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    chargesMaxController.dispose();
    super.dispose();
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
            Text(
              'You have pushed the button this many times:',
            ),
            Visibility(
              visible: priceupdate_value,
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            CheckboxListTile(
              // secondary: const Icon(Icons.question_answer_rounded),
              value: this.priceupdate_value,
              onChanged: (bool? priceupdateValue) {
                setState(() {
                  priceupdate_value = priceupdateValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
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
