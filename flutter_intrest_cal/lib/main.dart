import 'package:flutter/material.dart';
import './si_form.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark
      ),
      home: Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Intresrt App"),
        ),
        body: SiForm(),
      )));
}
