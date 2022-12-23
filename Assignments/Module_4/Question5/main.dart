import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Intent1());
}

class Intent1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Intent Example",
      debugShowCheckedModeBanner: false,
      home: IntentExample(),
    );
  }
}

class IntentExample extends StatelessWidget {
  var url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intent Example"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () async {
                  url = Uri.parse("tel:9725797073");
                  launch(url);
                },
                icon: Icon(Icons.call),
                label: Text("call")),
            ElevatedButton.icon(
                onPressed: () async {
                  url = Uri.parse("msg:9725797073");
                  launch(url);
                },
                icon: Icon(Icons.message),
                label: Text("message")),
            ElevatedButton.icon(
                onPressed: () async {
                  url = Uri.parse("share:9725797073");
                  launch(url);
                },
                icon: Icon(Icons.share),
                label: Text("share")),
            ElevatedButton.icon(
                onPressed: () async {
                  url = Uri.parse("email:akkypatel990@gmail.com");
                  launch(url);
                },
                icon: Icon(Icons.email),
                label: Text("email")),
          ],
        ),
      ),
    );
  }
}
