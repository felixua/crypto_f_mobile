import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:crypto_f_mobile/screens/home_page.dart';
import 'package:crypto_f_mobile/firebase/auth_service.dart';
import 'package:crypto_f_mobile/screens/auth_screen.dart';
import 'package:crypto_f_mobile/app_bloc_observer.dart';

import 'package:crypto_f_mobile/cubit/login_cubit.dart';

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
        authenticationRepository: AuthService(FirebaseAuth.instance),
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required AuthService authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

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
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const AuthenticationWrapper(),
          ),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const MyHomePage(title: 'Flutter Demo Home Page');
    }
    return const AuthScreen();
  }
}
