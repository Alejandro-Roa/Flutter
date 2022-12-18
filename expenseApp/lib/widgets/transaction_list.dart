import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    //optional define height and scroll for inner container too
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      //Listview is a scrolleable column with infinite height
      // build all widgets unlike ListView.builder() => long list
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    // remove full path on project or work on pojects
                    'D:/Adex/ProjectsWn/Flutter/expenseApp/lib/assets/images/shape.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (cntx, index) {
                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transactions[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => {deleteTx(transactions[index].id)},
                    ),
                  ),
                );

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
              },
              itemCount: transactions.length,
            ),
    );
  }
}
