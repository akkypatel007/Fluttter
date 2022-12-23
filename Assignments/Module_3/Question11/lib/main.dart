import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: BottonNavigationBar(),
    );
  }
}

class BottonNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bottom Navigation Bar",
      home: Navigation(),
    );
  }
}

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
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
        title: Text("Bottom Navigation Bar"),
      ),
      body: WidgetOption.elementAt(SetStateIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.browse_gallery),
              label: "Gallery",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.audio_file), label: "Audio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_back), label: "Video"),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: SetStateIndex,
        selectedItemColor: Colors.greenAccent,
        iconSize: 40,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      SetStateIndex = value;
    });
  }
}

class Detail {
  String id, name, image;

  Detail({required this.id, required this.name, required this.image});
}
