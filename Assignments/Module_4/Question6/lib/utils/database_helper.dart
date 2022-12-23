//@dart=2.9
import 'dart:io';

import 'package:module4_question6/model/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static DataBaseHelper _databaseHelper;

  static Database _database;

  String noteTable = 'note_table'; //TableName

  String colid = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DataBaseHelper._createInstance(); //declarecation singleton method

  factory DataBaseHelper() //Construction
  {
    if (_databaseHelper == null) {
      _databaseHelper = DataBaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //InitializeDataBase
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    /*var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;*/

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  //Create dataBase Table
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colid INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //Insert Data Into Tables
  Future<int> insertNote(Notes note) async {
    Database db1 = await this.database;
    var result = await db1.insert(noteTable, note.toMap());
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    //Asynchronous  Programming
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<List<Notes>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Notes> noteList = List<Notes>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Notes.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  //delete a note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colid =$id');
    return result;
  }

  Future<int> updateNote(Notes id) async {
    var db = await this.database;
    int result = await db
        .update(noteTable, id.toMap(), where: '$colid=?', whereArgs: [id.id]);
    return result;
  }
}
