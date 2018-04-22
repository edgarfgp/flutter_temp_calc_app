import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  double input;
  double output;
  bool forC;

  @override
  void initState() {
    input = 0.0;
    output = 0.0;
    forC = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch (e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
          labelText:
              "Input value in ${forC == false ? "Fahrenheit" : "Celciues"}",
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.green)),
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Text("F"),
          Radio<bool>(
            groupValue: forC,
            value: false,
            onChanged: (e) {
              setState(() {
                forC = e;
              });
            },
          ),
          Text("C"),
          Radio<bool>(
            groupValue: forC,
            value: true,
            onChanged: (e) {
              setState(() {
                forC = e;
              });
            },
          )
        ],
      ),
    );

    Container calcBtn = Container(
      child: RaisedButton(
        child: Text("Calculate"),
        onPressed: () {
          setState(() {
            forC == false
                ? output = (input - 32) * (5 / 9)
                : output = (input * 9 / 5) + 32;
          });
          AlertDialog dialog = AlertDialog(
            content: forC == false
            ? Text("${input.toStringAsFixed(3)} F : ${output.toStringAsFixed(3)} C")
            : Text("${input.toStringAsFixed(3)} C : ${output.toStringAsFixed(3)} F"),
          );
          showDialog(context:  context, child: dialog);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Temp Calc"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[inputField, tempSwitch, calcBtn],
        ),
      ),
    );
  }
}

// Switch(
//   value: forC,
//   onChanged: (e) {
//     setState(() {
//       forC = !forC;
//     });
//   },

// ),
// Checkbox(
//   value: forC,
//   onChanged: (e){
//     setState(() {
//     forC = !forC;
//   });
//   },
//   )
