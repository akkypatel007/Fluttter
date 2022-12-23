import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gmail App",
      debugShowCheckedModeBanner: false,
      home: AppDrawer(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appbar'),
      ),
      drawer: DrawerScreen(),
      body: Center(
          child: Container(
        child: Text('Drawer'),
      )),
    );
  }
}

List<Detail> Customer = [
  Detail(id: '1', name: 'Image-1', image: 'images/nature1.jpg'),
  Detail(id: '2', name: 'Image-2', image: 'images/nature2.jpg'),
  Detail(id: '3', name: 'Image-3', image: 'images/nature3.jpg'),
  Detail(id: '4', name: 'Image-4', image: 'images/nature4.jpg'),
  Detail(id: '5', name: 'Image-5', image: 'images/nature5.jpg'),
  Detail(id: '6', name: 'Image-6', image: 'images/nature6.jpg'),
];
List<Detail> Customer1 = [
  Detail(id: '1', name: 'Audio1', image: 'images/nature1.jpg'),
  Detail(id: '2', name: 'Audio2', image: 'images/nature2.jpg'),
  Detail(id: '3', name: 'Audio3', image: 'images/nature3.jpg'),
  Detail(id: '4', name: 'Audio4', image: 'images/nature4.jpg'),
  Detail(id: '5', name: 'Audio5', image: 'images/nature5.jpg'),
  Detail(id: '6', name: 'Audio6', image: 'images/nature6.jpg'),
];
List<Detail> Customer2 = [
  Detail(id: '1', name: 'Video-1', image: 'images/nature1.jpg'),
  Detail(id: '2', name: 'Video-2', image: 'images/nature2.jpg'),
  Detail(id: '3', name: 'Video-3', image: 'images/nature3.jpg'),
  Detail(id: '4', name: 'Video-4', image: 'images/nature4.jpg'),
  Detail(id: '5', name: 'Video-5', image: 'images/nature5.jpg'),
  Detail(id: '6', name: 'Video-6', image: 'images/nature6.jpg'),
];

class Detail {
  String id, name, image;

  Detail({required this.id, required this.name, required this.image});
}

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
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
          /*const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),*/
          ListTile(
            title: const Text('Images'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigation(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Audio'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigation1(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Video'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigation2(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int SetStateIndex = 0;
  List WidgetOption = [
    ListView.builder(
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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer Navigation Bar"),
      ),
      body: WidgetOption.elementAt(SetStateIndex),
    );
  }
}

class Navigation1 extends StatefulWidget {
  @override
  State<Navigation1> createState() => _NavigationState1();
}

class _NavigationState1 extends State<Navigation1> {
  int SetStateIndex = 0;
  List WidgetOption = [
    ListView.builder(
        itemCount: Customer1.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(Customer1[index].image),
              ),
              title: Text(Customer1[index].name),
            ),
          );
        }),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer Navigation Bar"),
      ),
      body: WidgetOption.elementAt(SetStateIndex),
    );
  }
}

class Navigation2 extends StatefulWidget {
  @override
  State<Navigation2> createState() => _NavigationState2();
}

class _NavigationState2 extends State<Navigation2> {
  int SetStateIndex = 0;
  List WidgetOption = [
    ListView.builder(
        itemCount: Customer2.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(Customer2[index].image),
              ),
              title: Text(Customer2[index].name),
            ),
          );
        }),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer Navigation Bar"),
      ),
      body: WidgetOption.elementAt(SetStateIndex),
    );
  }
}
