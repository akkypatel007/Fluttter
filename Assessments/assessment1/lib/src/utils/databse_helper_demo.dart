//@dart=2.9
import 'package:imfaa/src/model/note_demo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static DataBaseHelper _databaseHelper;

  static Database _database;

  String noteTable = 'note_table'; //TableName
  String deletedNotesTable = 'deleted_notes';

  String colid = 'id';
  String colProduct = 'product';
  String colCategory = 'category';
  String colPrice = 'price';
  String colQuantity = 'quantity';
  String colTotal = 'total';
  String colDate = 'date';
  String colDeleted = 'deleted';

  // Deleted notes table columns
  String colDeletedNotesId = 'id';
  String colDeletedNotesProduct = 'product';
  String colDeletedNotesCategory = 'category';
  String colDeletedNotesDate = 'date';
  String colDeletedNotesPrice = 'price';
  String colDeletedNotesQuantity = 'quantity';
  String colDeletedNotesTotal = 'total';
  String colDeletedNotesDeleted = 'deleted';

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
    _database ??= await initializeDatabase();
    return _database;
  }

  //InitializeDataBase
  // Future<Database> initializeDatabase() async {
  //   // Get the directory path for both Android and iOS to store database.
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String path = '${directory.path}notes.db';
  //
  //   // Open/create the database at a given path
  //   /*var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
  //   return notesDatabase;*/
  //
  //   return openDatabase(path, version: 1, onCreate: _createDb);
  // }
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    final directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path + 'notes.db');
    var notesDB = await openDatabase(path, version: 2, onCreate: _createDb);

    // await notesDB.execute(
    //     "ALTER TABLE $deletedNotesTable ADD COLUMN $colDeletedNotesDeleted INTEGER");
/*    await notesDB.execute('''CREATE TABLE $deletedNotesTable(
        $colDeletedNotesId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colDeletedNotesProduct TEXT,
        $colDeletedNotesCategory TEXT,
        $colDeletedNotesDate TEXT,
        $colDeletedNotesPrice INTEGER,
        $colDeletedNotesQuantity INTEGER,
        $colDeletedNotesTotal INTEGER)''');*/
    // Open/create the database at a given path
    // return await openDatabase(path, version: 1, onCreate: _createDb);

    return notesDB;
  }

  //Create dataBase Table
  // void _createDb(Database db, int newVersion) async {
  //   await db.execute(
  //       'CREATE TABLE $noteTable($colid INTEGER PRIMARY KEY AUTOINCREMENT,$colProduct TEXT,$colCategory TEXT,$colPrice TEXT,'
  //       '$colQuantity TEXT,$colDate TEXT,)');
  // }
  // void _createDb(Database db, int newVersion) async {
  //   await db.execute(
  //     'CREATE TABLE $noteTable($colid INTEGER PRIMARY KEY AUTOINCREMENT,$colProduct TEXT,$colCategory TEXT,$colPrice TEXT,'
  //     '$colQuantity TEXT,$colTotal TEXT,$colDate TEXT)',
  //   );
  // },
  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $noteTable($colid INTEGER PRIMARY KEY AUTOINCREMENT,$colProduct TEXT,$colCategory TEXT,$colPrice INTEGER,'
      '$colQuantity INTEGER,$colTotal INTEGER,$colDate TEXT,$colDeleted INTEGER)',
    );
    await db.execute('''CREATE TABLE $deletedNotesTable(
        $colDeletedNotesId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colDeletedNotesProduct TEXT,
        $colDeletedNotesCategory TEXT,
        $colDeletedNotesDate TEXT,
        $colDeletedNotesPrice INTEGER,
        $colDeletedNotesQuantity INTEGER,
        $colDeletedNotesTotal INTEGER,
        $colDeletedNotesDeleted INTEGER)''');
  }

  //Insert Data Into Tables
  Future<int> insertNote(Notes note) async {
    Database db1 = await database;
    var result = await db1.insert(noteTable, note.toMap());
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    //Asynchronous  Programming
    Database db = await database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(
      noteTable,
      orderBy: '$colid',
    );
    return result;
  }

  // Get all notes from the notes table
  Future<List<Notes>> getAllNotes() async {
    Database db = await this.database;
    List<Map<String, dynamic>> maps =
        await db.query(noteTable, where: '$colDeleted = 0');
    return List.generate(maps.length, (i) {
      return Notes.fromMapObject(maps[i]);
    });
  }

  // Get a note from the notes table by id
  Future<Notes> getNoteById(int id) async {
    Database db = await this.database;
    List<Map<String, dynamic>> maps = await db.query(noteTable,
        where: '$colid = ? AND $colDeleted = 0', whereArgs: [id]);
    if (maps.length > 0) {
      return Notes.fromMapObject(maps.first);
    }
    return null;
  }

  Future<List<Notes>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Notes> noteList = <Notes>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Notes.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  //delete a note object from database
  Future<int> deleteNote(int id) async {
    var db = await database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colid =$id');
    return result;
  }

  // Soft delete a note in the notes table by id
  Future<int> deleteNoteById(int id) async {
    Database db = await this.database;
    return await db.update(noteTable, {colDeleted: 1},
        where: '$colid = ?', whereArgs: [id]);
  }

  // Update a note in the notes table
  Future<int> updateNotes(Notes note) async {
    Database db = await this.database;
    return await db.update(noteTable, note.toMap(),
        where: '$colid = ? AND $colDeleted = 0', whereArgs: [note.id]);
  }

  Future<int> updateNote(Notes id) async {
    var db = await database;
    int result = await db
        .update(noteTable, id.toMap(), where: '$colid=?', whereArgs: [id.id]);
    return result;
  }

// Get all deleted notes from the deleted notes table
  Future<List<Notes>> getAllDeletedNotes() async {
    Database db = await this.database;
    List<Map<String, dynamic>> maps = await db.query(deletedNotesTable);
    return List.generate(maps.length, (i) {
      return Notes.fromMapObject(maps[i]);
    });
  }

// Permanently delete a note from the deleted notes table by id
  Future<int> deletePermanently(int id) async {
    Database db = await this.database;
    return await db.delete(deletedNotesTable,
        where: '$colDeletedNotesId = ?', whereArgs: [id]);
  }

// Add a note to the deleted notes table
  Future<int> addDeletedNote(Notes note) async {
    Database db = await this.database;
    return await db.insert(deletedNotesTable, note.toMap());
  }

  Future<int> getSum() async {
    var db = await database;
    var result = await db.rawQuery('SELECT SUM($colTotal) FROM $noteTable');
    return result[0]['SUM($colTotal)'];
  }
}
// Future<String> getTotalPrice() async {
//   final db = await database;
//   final List<Map<String, dynamic>> maps = await db.query(noteTable);
//   int total = 0;
//   for (int i = 0; i < maps.length; i++) {
//     total += maps[i][colPrice] * maps[i][colQuantity] as int;
//   }
//   return total as String;
// }
