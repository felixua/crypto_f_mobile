import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_f_mobile/cubit/login_cubit.dart';

import 'package:crypto_f_mobile/screens/auth_screen.dart';
import 'package:crypto_f_mobile/screens/transactions_screen.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginCubitState>(builder: ((context, state) {
      if (state.isAuthenticated == true) {
        return const TransactionsPage(title: 'Bitcoin (BTC)');
      } else {
        return const AuthScreen();
      }
    }));
  }
}
