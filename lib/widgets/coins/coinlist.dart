import 'package:crypto_f_mobile/cubit/coin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:crypto_f_mobile/models/coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinList extends StatelessWidget {
  final List<Coin> coins;
  const CoinList({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Item count ${coins.length}');
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            key: Key(coins[index].coin),
            margin: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 2.0,
            ),
            child: Dismissible(
              key: Key(UniqueKey().toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (_) =>
                  context.read<CoinCubit>().deleteCoin(coins[index].coin),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  size: 30,
                ),
              ),
              child: ListTile(
                leading: Text(
                  coins[index].coin,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                title: Text(coins[index].displayName),
              ),
            ),
          );
        },
        itemCount: coins.length,
      ),
    );
  }
}
