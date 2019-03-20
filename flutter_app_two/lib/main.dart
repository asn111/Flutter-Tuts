import 'package:flutter/material.dart';
import './app_screens/state_widget_eg.dart';
import './app_screens/home_screen.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugDumpRenderTree();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Section 3"),
        ),
        body: FavCity(),
      ),
  ));
}




/* add this in materialApp section to run code for longlist,snakbar and FAB.
home: Scaffold(
      appBar: AppBar(title: Text("Long List")),
      body: getLongListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB CLICKED");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        tooltip: 'This is tool tip.',
      ),
    ),
 */
void showSnakBar(BuildContext context) {
  var snakBar = SnackBar(
    content: Text("This is snackBar"),
    action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          debugPrint("UNDO PRESSED");
        }),
  );
  Scaffold.of(context).showSnackBar(snakBar);
}

// Long List elements gathering.
List<String> getListElements() {
  var items = List<String>.generate(10000, (counter) => "$counter");
  return items;
}

// Long List View
Widget getLongListView() {
  var listItems = getListElements();
  var listView = ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      leading: ImageAsset(),
      title: Text("List Item # ${listItems[index]}"),
      trailing: Icon(Icons.format_list_numbered_rtl),
      onTap: () {
        showSnakBar(context);
      },
    );
  });
  return listView;
}

// Basic List View
Widget getBasicListView() {
  var listView = ListView(
    padding: EdgeInsets.only(top: 64.0),
    children: <Widget>[
      ListTile(
        leading: Text(
          ("DP"),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.0, color: Colors.grey),
        ),
        title: Text("This is Title"),
        subtitle: Text("this is subtitile"),
        trailing: Icon(Icons.image),
      )
    ],
  );
  return listView;
}

// first class created. not using it in code.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Flutter App",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          body: Material(
            color: Colors.deepPurpleAccent[300],
            child: Center(
              child: Text("This is Body"),
            ),
          ),
        ));
  }
}
