import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_f_mobile/cubit/login_cubit.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //final TextEditingController emailController = TextEditingController();
  //final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _userRemember = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginCubitState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
          }
        },
        child: Center(
          child: Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                                key: const ValueKey('email'),
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value != null &&
                                      (value.isEmpty || !value.contains('@'))) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email address'.toString(),
                                ),
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .passwordChanged(value)),
                            TextFormField(
                              key: const ValueKey('password'),
                              validator: (value) {
                                if (value != null &&
                                    (value.isEmpty || value.length < 7)) {
                                  return 'Password must be at least 7 characters long.';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .passwordChanged(value),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Checkbox(
                                        checkColor: Colors.white,
                                        value: _userRemember,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _userRemember = value!;
                                          });
                                        }),
                                    const Expanded(
                                      child: Text('Remember me'),
                                    ),
                                  ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<LoginCubit>()
                                        .logInWithCredentials(),
                                    child: const Text('Sign in'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<LoginCubit>()
                                        .logInWithGoogle(),
                                    child: const Text('Sign in with Google'),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text('You can also '),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('sign up here'),
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Center(
                              widthFactor: double.infinity,
                              child: Text('@ 2021'),
                            ),
                          ],
                        ))),
              )),
        ));
  }
}
