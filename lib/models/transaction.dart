class Transaction {
  final String id;
  final String coin;
  final double amount;
  final DateTime dateTime;
  final String comments;
  final double price;
  final double priceUSD;
  final double spend;
  final double spendUSD;
  final String transactionType;
  final String user;
  final String wallet;

  Transaction(
      {required this.id,
      required this.coin,
      required this.amount,
      required this.dateTime,
      this.comments = "",
      required this.price,
      required this.priceUSD,
      required this.spend,
      required this.spendUSD,
      required this.transactionType,
      required this.user,
      this.wallet = "default"});
}
