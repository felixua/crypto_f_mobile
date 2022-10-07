part of 'coin_cubit.dart';

class CoinCubitState extends Equatable {
  final List<Coin> coinList;

  const CoinCubitState(this.coinList);

  @override
  List<Object> get props => [coinList];
}
