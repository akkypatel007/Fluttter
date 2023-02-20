//@dart=2.9
import 'package:flutter/material.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({Key key}) : super(key: key);

  @override
  State<ViewProductScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<ViewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product\'s'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff1f005a),
              Color(0xff1b0063),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Center(
          child: Text(
            "Coming soon....!",
            style: TextStyle(color: Colors.white, fontSize: 27),
          ),
        ),
      ),
    );
  }
}
