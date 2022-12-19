part of 'coin_cubit.dart';

class CoinCubitState extends Equatable {
  final List<Coin> coins;

  const CoinCubitState({required this.coins});

  List<Coin> get coinList => coins;

  @override
  List<Object> get props => [coinList];
}
