import 'package:flutter/material.dart';
import 'package:my_app/widgets/new_transaction.dart';

import '../widgets/transaction_list.dart';
import '../widgets/chart.dart';
import '../models/transaction.dart';

void main() => runApp(const Expenses());

class Expenses extends StatelessWidget {
  const Expenses({super.key});
  @override
  Widget build(BuildContext context) {
    // updated to secondaty color
    // final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: Colors.yellow, // update syntax
          errorColor: Colors.red,
          fontFamily: 'Open Sans',

          //   Not loading, check later
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
        //GestureDetector(
        //  onTap: () {},
        //child: NewTransaction(_addNewTransaction)
        // behavior: HitTestBehavior.opaque
        // prevent tap on modal sheet to hide
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 133, 131, 132),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Expenses App',
            style: TextStyle(fontFamily: 'Open Sans'),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: (() => _startAddNewTransaction(context)),
                icon: const Icon(Icons.add)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransaction),
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (() => _startAddNewTransaction(context)),
          child: const Icon(Icons.add),
        ));
  }
}
// methods to avoid lifting the state up to the common denominator ?
