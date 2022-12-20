import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    // stateless widgets dont need keys, every wid can have it
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor = Colors.black;
  @override
  void initState() {
    // const run time values wont change
    const availableColors = [Colors.red, Colors.black, Colors.blue];

    // states does not to be called because it runs after initState

    _bgColor = availableColors[Random().nextInt(3)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style:
              // TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
              Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(
            widget.transaction.date,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                onPressed: () => {widget.deleteTx(widget.transaction.id)},
                label: Text('Delete'),
                icon: Icon(Icons.delete),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => {widget.deleteTx(widget.transaction.id)},
              ),
      ),
    );
  }
}
