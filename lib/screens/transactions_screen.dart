import 'package:crypto_f_mobile/cubit/coin_cubit.dart';
import 'package:crypto_f_mobile/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_f_mobile/cubit/login_cubit.dart';
import 'package:crypto_f_mobile/models/transaction.dart';
import 'package:crypto_f_mobile/widgets/transactions/transactions.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  static List<Transaction> transactions = [
    Transaction(
        id: "1",
        coin: "ETH",
        amount: 0.07733000,
        dateTime: DateTime(2022, 4, 4, 17, 30),
        price: 48000,
        priceUSD: 369.19,
        spend: 3710.40,
        spendUSD: 28.53,
        transactionType: "1",
        user: "anton-g@yandex.ru",
        comments: "Test comment"),
    Transaction(
        id: "2",
        coin: "ETH",
        amount: 0.01333000,
        dateTime: DateTime(2022, 4, 4, 20, 30),
        price: 48000,
        priceUSD: 369.19,
        spend: 510.40,
        spendUSD: 6.13,
        transactionType: "1",
        user: "anton-g@yandex.ru",
        comments: "Test comment 2"),
  ];

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginCubitState>(
          listener: (context, state) => {},
        ),
        BlocListener<CoinCubit, CoinCubitState>(
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: const MainDrawer(),
        body: Transactions(transactions: TransactionsPage.transactions),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Add transaction',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
