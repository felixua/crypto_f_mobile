import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:crypto_f_mobile/router/app_router.dart';

import 'package:crypto_f_mobile/cubit/login_cubit.dart';
import 'package:crypto_f_mobile/cubit/coin_cubit.dart';

import 'package:crypto_f_mobile/firebase/auth_service.dart';
import 'package:crypto_f_mobile/app_bloc_observer.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      if (kIsWeb) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyDRKzzQhhbVIHqiqss6_afnaWDDO2VM32g',
            appId: '1:731522552432:web:8a49309b106bed257f1ab5',
            messagingSenderId: '448618578101',
            projectId: 'api-project-731522552432',
            authDomain: 'api-project-731522552432.firebaseapp.com',
            databaseURL: 'https://api-project-731522552432.firebaseio.com',
          ),
        );
      } else {
        await Firebase.initializeApp();
      }

      runApp(MyApp(
        appRouter: AppRouter(),
        authenticationRepository: AuthService(FirebaseAuth.instance),
      ));
    },
    //blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required AuthService authenticationRepository,
      required AppRouter appRouter})
      : _authenticationRepository = authenticationRepository,
        _appRouter = appRouter,
        super(key: key);
  final AppRouter _appRouter;
  final AuthService _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(_authenticationRepository),
          ),
          BlocProvider<CoinCubit>(
            create: (context) =>
                CoinCubit(loginState: context.read<LoginCubit>().state),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            backgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            primaryColor: Colors.blue,
            primaryColorDark: Colors.red,
            primaryColorLight: Colors.black,
            secondaryHeaderColor: Colors.black,
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
