import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/new_transaction.dart';
import 'package:flutter/services.dart';

import '../widgets/transaction_list.dart';
import '../widgets/chart.dart';
import '../models/transaction.dart';

void main() {
  // call object to utilize device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(const Expenses());
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  // context is metainfo about widgets element tree 'across comunication channel'
  // direct comunication cheanel to exchange data between widgets
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

// mixed 'add functionalities from multiple clasess and is used with a state class
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];

// adding a listener
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); // this class
    super.initState();
  }

  // call every time app reaches a new state in its lifecicle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  // clean listeners to lifecicle changes / avoid memory leaks
  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

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

  // buider methods 'return list o widgets or widgets
  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransaction)),
      txListWidget
    ];
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show/Hide Chart'),
          Switch.adaptive(
              // on IOS cupertino adjust look depending of the platform
              value: _showChart,
              onChanged: (getsValue) {
                setState(() {
                  _showChart = getsValue;
                });
              })
        ],
      ),
      _showChart // ternary expression
          ? // show chart
          Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransaction))
          : txListWidget
    ];
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
    //reuse object save re render cicles
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
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
    );

    // store widget template
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: Text(
                'Some IOS stuffs'), // check out docs for more cupertino widgets
          )
        : Scaffold(
            // backgroundColor: const Color.fromARGB(255, 133, 131, 132),
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // avoid curly braces for syntax 'if to add or not an element to the list NEAT
                  // using spread operator to take out all elements from inside the list to be added one by one
                  if (isLandscape)
                    ..._buildLandscapeContent(
                      mediaQuery,
                      appBar,
                      txListWidget,
                    ),

                  if (!isLandscape)
                    ..._buildPortraitContent(mediaQuery, appBar, txListWidget)
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Platform.isIOS
                ? // platforms
                Container()
                : FloatingActionButton(
                    onPressed: (() => _startAddNewTransaction(context)),
                    child: const Icon(Icons.add),
                  ));
  }
}
// methods to avoid lifting the state up to the common denominator ?
