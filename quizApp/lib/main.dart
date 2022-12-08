import 'package:flutter/material.dart';

import './result.dart';
import './quiz.dart';

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
  // var myAddress = const;

  // compiled time constant never change
  final _questions = const [
    // mapping key:anyvalue
    {
      'questionText': 'Name',
      'answer': [
        {'text': 'Santiago', 'score': 1},
        {'text': 'Juan', 'score': 2},
        {'text': 'Alejandro', 'score': 4},
        {'text': 'Rockie', 'score': 8},
      ],
    },
    {
      'questionText': 'Number',
      'answer': [
        {'text': '317 8003308', 'score': 4},
        {'text': '320 6516755', 'score': 2},
        {'text': '301 2318571', 'score': 1},
        {'text': '331 2342465', 'score': 8},
      ],
    },
    {
      'questionText': 'Age',
      'answer': [
        {'text': '25', 'score': 4},
        {'text': '19', 'score': 1},
        {'text': '27', 'score': 2},
        {'text': '29', 'score': 8},
      ],
    }
  ];

  var _questionIndex = 0;
  var _totalscore = 0;

  //reload method

  void _reloadApp() {
    _questionIndex = 0;
    _totalscore = 0;
    setState(() { 
    });
  }

  //manage state method
  void _showOption(int score) {
    _totalscore += score;

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
          title: Text('Login view'),
        ),
        body: _questions.length > _questionIndex // ternary expression
            //splitting widgets
            ? Quiz(
                showOption: _showOption,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_totalscore, _reloadApp), // else statement
      ),
    );
  }
}
