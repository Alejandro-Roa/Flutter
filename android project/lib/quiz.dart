import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function showOption;
  final int questionIndex;

  // passing named aguments
  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.showOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'] as String),

        //advanteges of elevated over raised -> main theme color by default
        // passing callback to custom widget so it can execute state method
        // mapping List into a list of widgets using an anonymous function
        // ... spread operator -> takes list's values from each iteration
        // and bind them with number of Answer widgets
        ...(questions[questionIndex]['answer'] as List<Map<String, Object>>).map((answer){
          return Answer(() => showOption(answer['score']), answer['text'] as String);
        }).toList() // converts value given from map to a list
      ],
      // else statement
    );
  }
}