import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_f_mobile/cubit/login_cubit.dart';
import 'package:crypto_f_mobile/models/coin.dart';
import 'package:crypto_f_mobile/widgets/coins/coinlist.dart';
import 'package:equatable/equatable.dart';

part 'coin_cubit_state.dart';

class CoinCubit extends Cubit<CoinCubitState> {
  final LoginCubitState loginState;
  CoinCubit({required this.loginState})
      : super(const CoinCubitState(coins: [])) {
    _monitorCoinList();
  }

  final coinsCollection = FirebaseFirestore.instance.collection("coins");
  StreamSubscription<List<Coin>>? coinListSubscription;

  Stream<List<Coin>> get coins {
    return coinsCollection
        .where("user", isEqualTo: loginState.email)
        .snapshots()
        .map(_coinListFromSnapshot);
  }

  StreamSubscription<List<Coin>> _monitorCoinList() {
    return coinListSubscription = coins.listen((coinList) {
      emit(CoinCubitState(coins: coinList));
    });
  }

  List<Coin> _coinListFromSnapshot(QuerySnapshot snapshot) {
    List<Coin> coinList = [];
    snapshot.docs.forEach((docRef) async {
      coinList.add(Coin(
          coin: docRef.get("coin") ?? "",
          displayName: docRef.get("displayName") ?? "",
          selected: false));
    });
    return coinList;
  }

  void addCoin(String coin, String displayName) {
    final Map<String, dynamic> newCoin = {
      'coin': coin,
      'displayName': displayName,
      'user': loginState.email
    };

    coinsCollection
        .add(newCoin)
        .then((_) => emit(CoinCubitState(coins: state.coinList)));
  }

  void deleteCoin(String coin) {
    coinsCollection
        .where("user", isEqualTo: loginState.email)
        .where("coin", isEqualTo: coin)
        .get()
        .then((snapshot) => snapshot.docs[0].reference.delete());
  }

  @override
  Future<void> close() {
    coinListSubscription?.cancel();
    return super.close();
  }
}
