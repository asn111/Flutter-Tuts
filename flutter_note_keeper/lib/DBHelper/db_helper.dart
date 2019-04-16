import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_note_keeper/models/notes.dart';
import 'package:path/path.dart' as p;


class DatabaseHelper {
  static DatabaseHelper databaseHelper;
  static Database database;

  String notesTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDecs = 'decs';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper.createInstance();

  factory DatabaseHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseHelper.createInstance();
    }
    return databaseHelper;
  }

  Future<Database> get _database async {
    if (database == null) {
      print('Init1');
      database = await initDB();
      print('Init2');
    }
    return database;
  }

  Future<Database> initDB() async {
    // Directory directory = await getApplicationDocumentsDirectory(); // old way of getting directory.
    // String path = directory.path + 'notes.db'; / old way of getting directory path.

    //Get directory path for both ios and android
    //import 'package:path/path.dart' as p;

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'notes.db'); // p will be declared on top as mentioned above.
    var notesDB = await openDatabase(path, version: 1, onCreate: createDB);
    print("Done");
    return notesDB;
  }

  void createDB(Database db, int newDB) async {
    await db.execute(
        'CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDecs TEXT, '
        '$colPriority INTEGER, $colDate TEXT)');
  }

  // CURD operations
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    var db = await this._database;
    var result = await db.query(notesTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(Notes note) async {
    var db = await this._database;
    var result = db.insert(notesTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Notes note) async {
    var db = await this._database;
    var result = db.update(notesTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this._database;
    var result = db.delete(notesTable, where: '$colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this._database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $notesTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // get the 'MapList' and convert it to 'NoteList'
  Future<List<Notes>> getNoteList() async {
    var noteMaplist = await getNoteMapList();
    int count = noteMaplist.length;

    List<Notes> noteList = List<Notes>();

    for (int i = 0; i < count; i++) {
      noteList.add(Notes.fromMapObject(noteMaplist[i]));
    }
    return noteList;
  }
}
