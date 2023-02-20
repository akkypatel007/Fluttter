import 'package:flutter/material.dart';

class MokeTestScreen extends StatelessWidget {
  const MokeTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Moke Test"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Coming Soon...!"),
      ),
    );
  }
}
