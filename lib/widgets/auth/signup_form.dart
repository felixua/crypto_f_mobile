import 'package:crypto_f_mobile/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_f_mobile/cubit/login_cubit.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  bool _userRemember = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginCubitState>(
        listener: (context, state) {
          if (!state.isAuthenticated) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
            }
          } else {
            Navigator.of(context).pop();
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
                                    .emailChanged(value)),
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
                            TextFormField(
                              key: const ValueKey('password2'),
                              validator: (value) {
                                if (value != null &&
                                    (value.isEmpty || value.length < 7)) {
                                  return 'Password must be at least 7 characters long.';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Repeat password'),
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .password2Changed(value),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        context.read<LoginCubit>().signUp(),
                                    child: const Text('Sign up'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Back to Sign in'),
                                  ),
                                ),
                              ],
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
