import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback triggerButton;
  // define as Function if fun recives arguments
  // void does not return anything and not recives arguments

  // constructor recieves a callback pointer to the main dart file funtion
  Answer(this.triggerButton, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 40, 168, 232)),
              // static property does not need to instantiate a.b
              // .preconfiguredValues ; class more like many props
              foregroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
            ),
            // not calling the funtion but given a pointer to it, not fun() usage here
            onPressed: triggerButton,
            child: Text(answerText)));
  }
}
