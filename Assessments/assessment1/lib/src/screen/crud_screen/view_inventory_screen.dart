//@dart=2.9
import 'package:flutter/material.dart';
import 'package:imfaa/src/model/note_demo.dart';
import 'package:imfaa/src/screen/crud_screen/add_product_screen.dart';
import 'package:imfaa/src/utils/databse_helper_demo.dart';
import 'package:sqflite/sqflite.dart';

class ViewInventoryScreen extends StatefulWidget {
  ViewInventoryScreen({this.total, Key key}) : super(key: key);
  var total;

  @override
  State<ViewInventoryScreen> createState() => _DeleteScreenState(total: total);
}

class _DeleteScreenState extends State<ViewInventoryScreen> {
  _DeleteScreenState({this.total});

  DataBaseHelper databaseHelper = DataBaseHelper();

  List<Notes> noteList;
  Notes notes;
  DeletedNotes deletedNotes;
  int count = 0;
  int _sum = 0;
  var total;

  Future<int> totalprice() async {
    var dbHelper = DataBaseHelper();
    int sum = await dbHelper.getSum();
    print("the total sum is $sum");
    setState(() {
      _sum = sum;
    });
  }

  @override
  void initState() {
    totalprice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Notes>[];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => const DashboardScreen(),
        //           ));
        //     },
        //     icon: const Icon(Icons.arrow_back)),
        title: const Text('Inventory\'s'),
      ),
      body: /*getNoteListView()*/
          Container(
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Number of Items=$count',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                  Text('Total sum \$=$_sum',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
              SingleChildScrollView(
                  child: SizedBox(
                      height: 650,
                      child: FutureBuilder<List<Notes>>(
                        future: databaseHelper.getAllNotes(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Notes>> snapshot) {
                          if (snapshot.hasData) {
                            List<Notes> notesList = snapshot.data;
                            // Render the notes list as you wish, for example:
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: notesList.length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                Notes note = notesList[position];
                                // count = noteList.length;

                                // Size size = MediaQuery.of(context).size;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 3),
                                      ),
                                      child: ListTile(
                                        title: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Item Name',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   width: 5,
                                                // ),
                                                Text(
                                                  note.product ?? "",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Item Category',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  note.category ?? "",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Item Price',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${note.price}" ?? "",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Item Quantity',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${note.quantity}" ?? "",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              note.date ?? "",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.grey,
                                          ),
                                          onTap: () async {
                                            databaseHelper.addDeletedNote(
                                                noteList[position]);
                                            await _delete(
                                                context, noteList[position]);
                                          },
                                        ),
                                        onTap: () {
                                          debugPrint("ListTile Tapped");
                                          navigateToDetail(
                                            'edit', /*noteList[position]*/
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ) /*ListView.builder(
                              itemCount: notesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Notes note = notesList[index];
                                return ListTile(
                                  title: Text(note.product),
                                  subtitle: Text(note.category),
                                );
                              },
                            )*/
                                ;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  ListView getNoteListView() {
    // TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      // shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        // Size size = MediaQuery.of(context).size;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.transparent,
            // height: size.height * 14 / 100,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white, width: 3),
            // ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Item Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        Text(
                          noteList[position].product,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Item Category',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          noteList[position].category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Item Price',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${noteList[position].price}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Item Quantity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${noteList[position].quantity}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),*/
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      noteList[position].date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, noteList[position]);
                  },
                ),
                onTap: () {
                  debugPrint("ListTile Tapped");
                  navigateToDetail(
                    'edit', /* noteList[position]*/
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToDetail(String s) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InsertScreen(appBarTitle: s);
    }));

    if (result == true) // by default false  update
    {
      updateListView();
    }
  }

  void updateListView() {
    DataBaseHelper dataBaseHelper = DataBaseHelper();
    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Notes>> noteListFuture = dataBaseHelper.getAllNotes();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, Notes noteList) async {
    DataBaseHelper dataBaseHelper = DataBaseHelper();

    int result = await dataBaseHelper.deleteNote(noteList.id);

    if (result != 0) {
      // ignore: use_build_context_synchronously
      _showSnackBar(context, 'Note Delete Successfully');
      updateListView();
    }
  }
}
