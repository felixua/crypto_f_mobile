import 'package:flutter/material.dart';
import 'package:crypto_f_mobile/models/coin.dart';

class CoinList extends StatelessWidget {
  final List<Coin> coins;
  const CoinList({Key? key, required this.coins}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            key: Key(coins[index].coin),
            margin: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 2.0,
            ),
            child: ListTile(
              leading: Text(
                coins[index].coin,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              title: Text(coins[index].displayName),
            ),
          );
        },
        itemCount: coins.length,
      ),
    );
  }
}
