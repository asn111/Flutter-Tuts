import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_note_keeper/models/notes.dart';
import 'package:flutter_note_keeper/DBHelper/db_helper.dart';
import 'package:intl/intl.dart';


class NEnterView extends StatefulWidget {
  final String appBarTitle;
  final Notes note;

  NEnterView(this.note,this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteEnterView(this.note,this.appBarTitle);
  }
}

class NoteEnterView extends State<NEnterView> {
  String appBarTitle;
   Notes note;

  NoteEnterView(this.note,this.appBarTitle);

  var count = 0;
  var priority = ["High", "Low"];
  var currentValue = "Low";
  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleCon.text = note.title;
    descCon.text = note.decs;
    dateCon.text = note.date;
    return
      // if I add this piece of code it will not allow ios App swipe left to go back, feature.
      /* WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: )*/
        Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                      items: priority.map((String dddItem) {
                        return DropdownMenuItem<String>(
                          value: dddItem,
                          child: Text(dddItem),
                        );
                      }).toList(),
                      style: textStyle,
                      //(updatePriority(null, note.priority) == null)?"NONE":updatePriority(null, note.priority)
                      value: getPriorityAsString(note.priority),
                      onChanged: (valueChanged) {
                        setState(() {
                          currentValue =  updatePriorityAsInt(valueChanged);
//                          if ((updatePriority(valueChanged, null) == null)) {
//                            currentValue = "NONE";
//                          } else {
//                            currentValue = updatePriority(valueChanged, null);
//                          }
                          debugPrint('$valueChanged');
                        });
                      }),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: titleCon,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'To do',
                          hintText: 'Enter what you want To-do',
                          errorStyle: TextStyle(color: Colors.yellow),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextField(
                      controller: descCon,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something changed in Description Text Field');
                        updateDescription();
                      },
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'Description',
                          hintText: 'Enter the Description.',
                          errorStyle: TextStyle(color: Colors.yellow),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only( bottom: 15.0),
                    child: TextField(
                      controller: dateCon,
                      style: textStyle,
                      onChanged: (value) {
                        value = note.date = DateFormat.yMMMd().format(DateTime.now());
                      },
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'Add Date And Time',
                          hintText: 'Enter the Date and Time when you want to deliver.',
                          errorStyle: TextStyle(color: Colors.yellow),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text("Save"),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save Pressed");
                              saveNote();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 10.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text("Delete/Cancel"),
                          onPressed: () {
                            setState(() {
                              debugPrint("Cencel Pressed");
                              deleteNote();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }

  // Convert the String priority in the form of integer before saving it to Database
  updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priorite;
    switch (value) {
      case 1:
        priorite = priority[0];  // 'High'
        break;
      case 2:
        priorite = priority[1];  // 'Low'
        break;
    }
    return priorite;
  }


  /*String updatePriority(String value1, int value2) {
    String priority;
    if (value1 != null) {
      switch (value1) {
        case 'High':
          note.priority = 1;
          break;
        case 'Low':
          note.priority = 2;
          break;
      }
    } else {
      switch (value2) {
        case 1:
          priority = priority[0];
          break;
        case 2:
          priority = priority[1];
          break;
      }
    }
    return priority;
  }*/

  // Update the title of Note object
  void updateTitle(){
    note.title = titleCon.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.decs = descCon.text;
  }

  saveNote() async {
    Navigator.pop(context,true);
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }
    if (result != 0) {
      showSnackBar('Status','Note Saved Successfully');
    } else {
      showSnackBar('Status','Problem Saving Note');
    }
  }

  deleteNote() async{
    Navigator.pop(context, true);
    if (note.id != null) {
      await helper.deleteNote(note.id);
      showSnackBar('Status','Note Deleted Successfully');
    } else {
      showSnackBar('Status','Problem Deleting Note');
    }
  }

  showSnackBar(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }
}
