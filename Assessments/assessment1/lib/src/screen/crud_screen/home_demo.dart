/*
//@dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imfaa/src/model/note_demo.dart';
import 'package:imfaa/src/screen/crud_screen/note_detail_demo.dart';
import 'package:imfaa/src/utils/databse_helper_demo.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  DataBaseHelper databaseHelper = DataBaseHelper();
  List<Notes> noteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Notes>[];
      UpdateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('click');
          navigateToDetail(Notes('', '', '', '', '')); //click -> msg
        },
        tooltip: 'add note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            */
/*leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.noteList[position].product[0]),
              child: getPriorityIcon(this.noteList[position].priority),
            ),*/ /*

            title: Text(
              this.noteList[position].product,
              style: titleStyle,
            ),
            subtitle: Text(this.noteList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Notes notes, String s) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(notes, s);
    }));

    if (result == true) // by default false  update
    {
      UpdateListView();
    }
  }

  void UpdateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Notes>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Notes noteList) async {
    int result = await databaseHelper.deleteNote(noteList.id);

    if (result != 0) {
      _showSnackBar(context, 'Note Delete Successfully');
      UpdateListView();
    }
  }
}
*/
