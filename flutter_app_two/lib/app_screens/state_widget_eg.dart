import 'package:flutter/material.dart';

class FavCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavCityState();
  }
}

class FavCityState extends State<FavCity> {
  String nameCity = "";
  var curruncy = ["PKR", "DLR", "EURO", "YEN","DHR"];
  // this is dropdown initial value and cannot be null.
  var curruncyItem = "PKR";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text("Enter some text below"),
          Container(
            color: Colors.black45,
            height: 1.0,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 15),
            child: TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  nameCity = userInput;
                  curruncy.add(nameCity);
                  curruncyItem = nameCity;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: DropdownButton<String>(
              items: curruncy.map((String dropDownItem){
                return DropdownMenuItem<String>(
                  value: dropDownItem,
                  child: Text(dropDownItem),
                );
              }).toList(),
              onChanged: (String newValueSelected){
                setState(() {
                  this.curruncyItem = newValueSelected;
                });
              },
              value: curruncyItem,
            )
          ),
          Padding( 
              padding: EdgeInsets.all(5.0),
              child: Text(
                "$nameCity",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ))
        ],
      ),
    );
  }
}
