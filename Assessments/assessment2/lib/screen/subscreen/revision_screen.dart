import 'package:flutter/material.dart';

class RevisionScreen extends StatelessWidget {
  const RevisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Revision"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Coming Soon...!"),
      ),
    );
  }
}
