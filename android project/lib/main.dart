import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

//functions with one and only expresion
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // overide dart , cleaner code to override existing method
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// direct parent -> lifting the state app 'manage state'
class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  // var myAddress = const;

  // compiled time constant never change
  final _questions = const [
    // mapping key:anyvalue
    {
      'questionText': 'Name',
      'answer': ['Santiago', 'Juan', 'Alejandro', 'Rockie']
    },
    {
      'questionText': 'Number',
      'answer': ['3178003308', '320 6516755', '301 2318571']
    },
    {
      'questionText': 'Age',
      'answer': ['25', '19', '27']
    }
  ];

  //manage state method
  void _showOption() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    //material app is a class
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Howdy'),
        ),
        body: _questions.length > _questionIndex
            ?
            // ternary expression
            Column(
                children: [
                  Question(_questions[_questionIndex]['questionText'] as String),

                  //advanteges of elevated over raised -> main theme color by default
                  // passing callback to custom widget so it can execute state method
                  // mapping List into a list of widgets using an anonymous function
                  // ... spread operator -> takes list's values from each iteration
                  // and bind them with number of Answer widgets
                  ...(_questions[_questionIndex]['answer'] as List<String>)
                      .map((answer) {
                    return Answer(_showOption, answer);
                  }).toList() // converts value given from map to a list
                ],
                // else statement
              )
            : Center(
                child: Text('Finished'),
              ),
      ),
    );
  }
}
