import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  // build tree creates new objects there for const and final values dont affect app
  // mark widgets as const to prevent them to rebuild such as Text

  @override
  Widget build(BuildContext context) {
    //optional define height and scroll for inner container too
    return Container(
      //Listview is a scrolleable column with infinite height
      // build all widgets unlike ListView.builder() => long list
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      // remove full path on project or work on pojects
                      'lib/assets/images/shape.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView(
              // keys are needed when working with a statefull widget and a top most item in a list
              // create key in the direct child of the list or listview
              // 'super' creates instace of parent class, used when needing to pass a key mostly
              // creates instance and passes key when one is needed
              children: transactions
                  .map(
                    (tx) => TransactionItem(
                      // key: UniqueKey(),  forwarding a key to item class but with every call, it rebuilds
                      key: ValueKey(tx.id), // forwarding own identifier
                      transaction: tx,
                      deleteTx: deleteTx,
                    ),
                  )
                  .toList(),
            ),
    );

    //ListView.builder(
    // itemBuilder: (cntx, index) {
    // changed to Listview insted to work with keys, 'keys need to be used in the root level widget and every widget can have it

    // return ListView(

    // TransactionItem(
    //     transaction: transactions[index], deleteTx: deleteTx);

    // Card(
    //   child: Row(
    //     children: <Widget>[
    //       Container(
    //         margin: const EdgeInsets.symmetric(
    //           vertical: 10,
    //           horizontal: 15,
    //         ),
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: Colors.purple,
    //             width: 2,
    //           ),
    //         ),
    //         padding: const EdgeInsets.all(10),
    //         child: Text(
    //           // interpolation does not require to String concatenate Strings
    //           '\$${transactions[index].amount.toStringAsFixed(2)}',

    //           // change title style based on theme setting
    //           // style: Theme.of(context).textTheme.titleMedium,

    //           style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //             color: Colors.purple,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Text(
    //             transactions[index].title,
    //             style: Theme.of(context).textTheme.headline6,
    //           ),
    //           Text(
    //             DateFormat.yMMMd().format(transactions[index].date),
    //             style: const TextStyle(
    //               color: Colors.grey,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    // no item count nedeed
    //itemCount: transactions.length,
  }
}
