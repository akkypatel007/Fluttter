//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imfaa/src/model/note_demo.dart';
import 'package:imfaa/src/screen/crud_screen/add_product_screen.dart';
import 'package:imfaa/src/screen/crud_screen/delete_product_screen.dart';
import 'package:imfaa/src/screen/crud_screen/view_inventory_screen.dart';
import 'package:imfaa/src/screen/crud_screen/view_product_screen.dart';
import 'package:imfaa/src/utils/databse_helper_demo.dart';
import 'package:imfaa/src/widget/custom_clip.dart';
import 'package:sqflite/sqflite.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const TextStyle style = TextStyle(color: Colors.white);
  List cards = [
    {'image': 'assets/images/plus.png', 'title': 'Add Product'},
    {'image': 'assets/images/delete.png', 'title': 'Delete Product'},
    {'image': 'assets/images/view.png', 'title': 'View Product'},
    {'image': 'assets/images/dollar.png', 'title': 'View Inventory'},
  ];
  List<Notes> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Inventory Management'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomClip(),
                  child: Container(
                    height: 200,
                    width: 400,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 13),
                      child: Text('Welcome, heaven',
                          style: GoogleFonts.allura(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.deepOrangeAccent,
                              shadows: List.filled(2, Shadow()))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cards.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          if (i == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InsertScreen(appBarTitle: ''),
                                ));
                          } else if (i == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeleteScreen(),
                                ));
                          } else if (i == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewProductScreen(),
                                ));
                          } else if (i == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewInventoryScreen(),
                                ));
                          }
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.all(16),
                            padding: EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    cards[i]['image'],
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    cards[i]['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 180,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void UpdateListView() {
    DataBaseHelper dataBaseHelper = DataBaseHelper();

    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Notes>> noteListFuture = dataBaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }
}
