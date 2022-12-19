import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_f_mobile/models/coin.dart';
import 'package:crypto_f_mobile/cubit/coin_cubit.dart';

class AddNewCoinScreen extends StatefulWidget {
  const AddNewCoinScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCoinScreen> createState() => _AddNewCoinScreenState();
}

class _AddNewCoinScreenState extends State<AddNewCoinScreen> {
  final TextEditingController coinController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new coin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                        key: const ValueKey('coin'),
                        controller: coinController,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.characters,
                        decoration:
                            InputDecoration(labelText: 'Coin'.toString()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                        key: const ValueKey('displayName'),
                        controller: displayNameController,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration:
                            InputDecoration(labelText: 'Coin Name'.toString()),
                      ),
                    ),
                  ]),
                ),
                Center(
                  child: Center(
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.save,
                        size: 30,
                      ),
                      label: const Text("Save"),
                      onPressed: () {
                        context.read<CoinCubit>().addCoin(
                            coinController.text.toUpperCase().trim(),
                            displayNameController.text.trim());
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
