import 'package:flutter/material.dart';
import 'package:crypto_f_mobile/widgets/auth/auth_wrapper.dart';
import 'package:crypto_f_mobile/screens/transactions_screen.dart';
import 'package:crypto_f_mobile/screens/edit_coinlist_screen.dart';
import 'package:crypto_f_mobile/screens/add_new_coin_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const AuthenticationWrapper(),
        );
      case '/coinlist':
        return MaterialPageRoute(
          builder: (_) => const EditCoinListScreen(),
        );
      case '/addNewCoin':
        return MaterialPageRoute(
          builder: (_) => const AddNewCoinScreen(),
        );
      case '/transations':
        return MaterialPageRoute(
          builder: (_) => const TransactionsPage(title: 'Bitcoin (BTC)'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Container(),
          ),
        );
    }
  }
}
