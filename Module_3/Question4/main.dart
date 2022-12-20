import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Modual3 question5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum answer { Rajkot, Ahmedabad, Surat, Baroda, Gandhinagar, Bharuch, Junagadh }

class _MyHomePageState extends State<MyHomePage> {
  String _value = '';
  void _setValue(String value) {
    setState(() {
      _value = value;
    });
  }

  Future _askUser() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select one City'),
            children: [
              SimpleDialogOption(
                child: Text('Rajkot'),
                onPressed: () {
                  Navigator.pop(context, answer.Rajkot);
                },
              ),
              SimpleDialogOption(
                child: Text('Ahmedabad'),
                onPressed: () {
                  Navigator.pop(context, answer.Ahmedabad);
                },
              ),
              SimpleDialogOption(
                child: Text('Surat'),
                onPressed: () {
                  Navigator.pop(context, answer.Surat);
                },
              ),
              SimpleDialogOption(
                child: Text('Baroda'),
                onPressed: () {
                  Navigator.pop(context, answer.Baroda);
                },
              ),
              SimpleDialogOption(
                child: Text('Gandhinagar'),
                onPressed: () {
                  Navigator.pop(context, answer.Gandhinagar);
                },
              ),
              SimpleDialogOption(
                child: Text('Bharuch'),
                onPressed: () {
                  Navigator.pop(context, answer.Bharuch);
                },
              ),
              SimpleDialogOption(
                child: Text('Junagadh'),
                onPressed: () {
                  Navigator.pop(context, answer.Junagadh);
                },
              ),
            ],
          );
        })) {
      case answer.Rajkot:
        _setValue('Rajkot');
        break;
      case answer.Ahmedabad:
        _setValue('Ahmedabad');
        break;
      case answer.Surat:
        _setValue('Surat');
        break;
      case answer.Baroda:
        _setValue('Baroda');
        break;
      case answer.Gandhinagar:
        _setValue('Gandhinagar');
        break;
      case answer.Bharuch:
        _setValue('Bharuch');
        break;
      case answer.Junagadh:
        _setValue('Junagadh');
        break;
    }
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
              'Your Next Destination is :',
            ),
            Text(
              _value,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 15),
            ElevatedButton(onPressed: _askUser, child: Text('Select City'))
          ],
        ),
      ),
    );
  }
}
