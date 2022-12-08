import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int validation;
  final VoidCallback reload;

  Result(this.validation, this.reload);

  // getter 'mix of propertie and method'
  String get access {
    String finalMessage;
    if (validation == 3) {
      finalMessage = 'Welcome back Santiago!';
    } else if (validation == 6) {
      finalMessage = 'Welcome back Juan!';
    } else if (validation == 12) {
      finalMessage = 'Welcome back Alejandro!';
    } else {
      finalMessage = 'Undentefied!';
    }
    return finalMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //quick fix ctrl+.
      child: Column(
        children: <Widget>[
          Text(access,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          //elevated does not support arguments color and text color but style
          // picks auto theme color
          OutlinedButton( // used to be outline
              style: OutlinedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
                side: BorderSide(color: Colors.blue),
              ),
              onPressed: reload,
              child: Text('Reload App')),
          ElevatedButton( // used to be raised
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 0, 0),
                  onPrimary: Color.fromARGB(255, 3, 155, 210)),
              onPressed: reload,
              child: Text('Reload App')),
          TextButton( // used to be flat
              style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 1, 162, 255)),
              onPressed: reload,
              child: Text('Reload App'))
        ],
      ),
    );
  }
}

// primary element from widget def