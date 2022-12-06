import 'package:flutter/material.dart';

class Question extends StatelessWidget {

  // final -> run time constant , will be assigned and never change 
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {

    //Enums 'framework code' and multiple constructors
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
