import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_f_mobile/cubit/coin_cubit.dart';
import 'package:crypto_f_mobile/widgets/coins/coinlist.dart';

class EditCoinListScreen extends StatelessWidget {
  const EditCoinListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final coins = context.read<CoinCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit coin list"),
      ),
      body: Column(
        children: [
          BlocBuilder<CoinCubit, CoinCubitState>(
            builder: (context, state) {
              //print('New state: ${state.coinList.length} coins');
              return CoinList(coins: context.read<CoinCubit>().state.coinList);
            },
          ),
          Center(
            child: TextButton.icon(
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              label: const Text("Add new coin"),
              onPressed: () => Navigator.of(context).pushNamed('/addNewCoin'),
            ),
          ),
        ],
      ),
    );
  }
}
