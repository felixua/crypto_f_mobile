import 'package:flutter/material.dart';
import 'package:crypto_f_mobile/firebase/auth_service.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  bool _userRemember = false;

  void _signInWithEmailAndPassword(ctx) {
    context
        .read<AuthService>()
        .signInEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
        .then((res) => {
              if (!res)
                {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          context.read<AuthService>().errorMessage.toString()),
                      backgroundColor: Theme.of(context).errorColor,
                    ),
                  )
                }
            });
  }

  void _signInWithGoogle(ctx) {
    context.read<AuthService>().signInWithGoogle().then((res) => {
          if (!res)
            {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(context.read<AuthService>().errorMessage.toString()),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              )
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                          controller: emailController,
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
                          onSaved: (value) {
                            _userEmail = value.toString();
                          },
                        ),
                        TextFormField(
                          key: const ValueKey('password'),
                          controller: passwordController,
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
                          onSaved: (value) {
                            _userPassword = value.toString();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                onPressed: () =>
                                    _signInWithEmailAndPassword(context),
                                child: const Text('Sign in'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ElevatedButton(
                                onPressed: () => _signInWithGoogle(context),
                                child: const Text('Sign in with Google'),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
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
    );
  }
}
