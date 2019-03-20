import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //        // margin against all sides of main body.
      margin: EdgeInsets.only(left: 0, bottom: 0, top: 0),
      padding: EdgeInsets.only(left: 10.0, top: 40.0, right: 10.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.purple, width: 3.0)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                border: Border.all(color: Colors.red, width: 2.0)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "First Row",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.normal,
                      fontSize: 40,
                      fontFamily: 'Margarine',
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple),
                )),
                Expanded(
                    child: Text(
                  "In Column",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.normal,
                      fontSize: 40,
                      fontFamily: 'Margarine',
                      fontWeight: FontWeight.w700,
                      color: Colors.purple),
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7.0),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(color: Colors.orange, width: 2.0)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "2nd row-Start",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.normal,
                      fontSize: 40,
                      fontFamily: 'Margarine',
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple),
                )),
                Expanded(
                    child: Text(
                  "2nd row-end",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.normal,
                      fontSize: 40,
                      fontFamily: 'Margarine',
                      fontWeight: FontWeight.w700,
                      color: Colors.purple),
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                border: Border.all(color: Colors.purple, width: 1.5)),
            child: Column(
              children: <Widget>[
                ImageAsset(),
                ChangeBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/radio_btn_checked.png');
    Image image = Image(
      image: assetImage,
      width: 20,
      height: 20,
    );
    return Container(
      child: image,
      padding: EdgeInsets.all(20),
    );
  }
}

class ChangeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.all(20.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
          color: Colors.teal,
          child: Text("Uncheck Button"),
          elevation: 6.0,
          onPressed: () {
            showAlert(context);
          }),
    ));
  }

  void showAlert(BuildContext context) {
    var alertDialog = AlertDialog(
      backgroundColor: Colors.red,
      title: Text('This is AlertBox title'),
      content: Text('This is Alert Box Content which can have long text'),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
