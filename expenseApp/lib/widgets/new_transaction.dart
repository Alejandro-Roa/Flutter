import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // input values must be always string and then converted

  // stateless widgets dont keep state of input data 'changed to statefull'
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  // refactor reutizice code
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final amountEntered = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || amountEntered <= 0) {
      // returns stops the funtion execution
      return;
    }

    // refactored 'widget. can access parent class'
    widget.addTx(
      enteredTitle, 
      amountEntered,
      _selectedDate,
      );

    // navigation section -> close top most screen displayed
    // propertie context 'object with lotta metadata about the widget and its possition on the tree'
    // avaliable on statefull to access context from current state class
    Navigator.of(context).pop();
  }

  void _currentDatePicked() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1997),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              // _ ignoring argument
              onSubmitted: (_) => {_submitData()},
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => {_submitData()},
              // onChanged: (val) => amountInput = val,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                    ),
                    onPressed: _currentDatePicked,
                    child: const Text(
                      'Choose date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  //onPrimary: Theme.of(context).primaryColor,
                ),
                onPressed: _submitData,
                child: const Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
