import 'package:flutter/material.dart';

class SiForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SiFormState();
  }
}

class SiFormState extends State<SiForm> {
  var curruncy = ["PKR", "DLR", "EURO", "YEN", "DHR"];

  // this is dropdown initial value and cannot be null.
  var curruncyItem = "";
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    curruncyItem = curruncy[0];
  }

  TextEditingController pAC = TextEditingController();
  TextEditingController iRC = TextEditingController();
  TextEditingController term = TextEditingController();
  var displayRes = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          getImage(),
          Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: pAC,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter some value in order to proceed.";
                  }
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: 'Principle Amount',
                    hintText: 'Enter principle amount e.g. 10000',
                    errorStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              )),
          Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: iRC,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter some value in order to proceed.";
                  }
                },
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    labelText: 'Intrest Rate',
                    hintText: 'Enter Intrest rate in Percent',
                    errorStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              )),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: term,
                    style: textStyle,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please Enter some value in order to proceed.";
                      }
                    },
                    decoration: InputDecoration(
                        labelStyle: textStyle,
                        labelText: 'Term',
                        hintText: 'Time in Years',
                        errorStyle: TextStyle(color: Colors.yellow),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Container(
                  width: 50.0,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    items: curruncy.map((String ddMenuItem) {
                      return DropdownMenuItem<String>(
                        value: ddMenuItem,
                        child: Text(ddMenuItem),
                      );
                    }).toList(),
                    onChanged: (String changedValue) {
                      setState(() {
                        curruncyItem = changedValue;
                      });
                    },
                    value: curruncyItem,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text("Calculate", style: textStyle),
                    onPressed: () {
                      setState(() {
                        if (formKey.currentState.validate()) {
                          this.displayRes = calculateTotalReturn();
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    child: Text(
                      "Reset",
                      style: textStyle,
                    ),
                    onPressed: () {
                      setState(() {
                        reset();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(this.displayRes, style: textStyle),
          ),
        ],
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('images/radio_btn_checked.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      margin: EdgeInsets.all(50.0),
      child: image,
    );
  }

  String calculateTotalReturn() {
    double princ = double.parse(pAC.text);
    double ir = double.parse(iRC.text);
    double termm = double.parse(term.text);
    double totaleAmount = princ + (princ * ir * termm) / 100;
    String res =
        "After $termm years your investment will be worth of $totaleAmount $curruncyItem ";
    return res;
  }

  reset() {
    pAC.text = "";
    iRC.text = "";
    term.text = "";
    curruncyItem = curruncy[0];
  }
}
