import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_f_mobile/cubit/coin_cubit.dart';
import 'package:crypto_f_mobile/widgets/coins/coinlist.dart';

class EditCoinListScreen extends StatelessWidget {
  const EditCoinListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coins = context.read<CoinCubit>();

    return BlocListener<CoinCubit, CoinCubitState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            CoinList(coins: coins.state.coinList),
            Center(
              child: TextButton.icon(
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
                label: const Text("Add new coin"),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
