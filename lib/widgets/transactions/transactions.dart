import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:crypto_f_mobile/models/transaction.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> transactions;

  const Transactions({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          key: Key(transactions[index].id),
          margin: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 5.0,
          ),
          child: ListTile(
            title: Text(DateFormat('yyyy-MM-dd HH:mm')
                .format(transactions[index].dateTime)),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transactions[index].comments),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      transactions[index].wallet,
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ]),
            //isThreeLine: true,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transactions[index].amount.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  transactions[index].spend.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
