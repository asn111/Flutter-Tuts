import 'package:flutter/material.dart';
import 'package:flutter_note_keeper/Screens/note_details.dart';
import 'dart:async';
import 'package:flutter_note_keeper/models/notes.dart';
import 'package:flutter_note_keeper/DBHelper/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class NListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListView();
  }
}

class NoteListView extends State<NListView> {
  var count = 0;

  // singlton insctance of DB Helper class
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notes> noteList;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Notes>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Keeper"),
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoNotes(Notes(2, '', ''),'Create Note');
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteList() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),
            title: Text(
              "${this.noteList[position].priority}",
              style: titleStyle,
            ),
            subtitle: Text('${this.noteList[position].date}'),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.blueGrey,
              ),
              onTap: () {
                delete(context, noteList[position]);
              },
            ),
            onTap: () {
              gotoNotes(this.noteList[position],'Edit Note');
            },
          ),
        );
      },
    );
  }

  //Navigation
  void gotoNotes(Notes note, String text) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NEnterView(note, text);
    }));
    if (result) {
      updateListView();
    }
  }

  // Returns The priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  // Return priority Icon
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

// Delete note
  void delete(BuildContext context, Notes note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      showSnackBar(context, 'Note deleted successfully.');
      updateListView();
    }
  }

  // Snack bar
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  // Update list view
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDB();
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
}
