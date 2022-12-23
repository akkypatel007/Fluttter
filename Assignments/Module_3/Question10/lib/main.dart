import 'package:flutter/material.dart';

void main() {
  runApp(Gmail());
}

class Gmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gmail App",
      debugShowCheckedModeBanner: false,
      home: AppGmail(),
    );
  }
}

class AppGmail extends StatefulWidget {
  @override
  State<AppGmail> createState() => _AppGmailState();
}

class _AppGmailState extends State<AppGmail> {
  List<EmailDetail> Customer = [
    EmailDetail(id: '1', name: 'Akshay', image: 'images/nature1.jpg'),
    EmailDetail(id: '2', name: 'Divya', image: 'images/nature2.jpg'),
    EmailDetail(id: '3', name: 'Hamir', image: 'images/nature3.jpg'),
    EmailDetail(id: '4', name: 'Krishna', image: 'images/nature4.jpg'),
    EmailDetail(id: '5', name: 'Vishnu', image: 'images/nature5.jpg'),
    EmailDetail(id: '6', name: 'Ram', image: 'images/nature6.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gmail"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Akshay"),
              accountEmail: Text("AKKY@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Image(
                  width: 55,
                  image: AssetImage("images/nature1.jpg"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text("Send"),
            ),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text("Draft"),
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text("Send"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("LogOut"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Mail",
        onPressed: () {},
        child: Icon(Icons.mail),
      ),
      body: ListView.builder(
          itemCount: Customer.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(Customer[index].image),
                ),
                title: Text(Customer[index].name),
              ),
            );
          }),
    );
  }
}

class EmailDetail {
  String id, name, image;

  EmailDetail({required this.id, required this.name, required this.image});
}
