import 'package:flutter/material.dart';
import 'package:flutter_note_keeper/Screens/ui_list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch:  Colors.deepPurple
    ),
    home: NListView()
  ));
}
