import 'package:flutter/material.dart';

//functions with one and only expresion
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // overide dart , cleaner code to override existing method
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var possitionList = 0;

  //methods
  void showOption() {
    setState(() {
      possitionList = possitionList + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var myList = [
      'name',
      'number',
      'age',
    ];
    //material app is a class
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Howdy'),
        ),
        body: Column(
          children: [
            Text(myList[possitionList]),
            ElevatedButton(onPressed: showOption, child: Text('first')),
            ElevatedButton(
                onPressed: () => print('anonymous pressed'),
                child: Text('second')),
            ElevatedButton(
                onPressed: () {
                  //..
                  print('serie of commands button pressed');
                },
                child: Text('third')),
          ],
        ),
      ),
    );
  }
}
