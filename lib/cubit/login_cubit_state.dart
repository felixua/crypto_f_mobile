part of 'login_cubit.dart';

class LoginCubitState extends Equatable {
  final String email;
  final String password;
  final String password2;
  final String errorMessage;
  final bool isAuthenticated;

  const LoginCubitState(
      {this.email = "",
      this.password = "",
      this.password2 = "",
      this.isAuthenticated = false,
      this.errorMessage = ""});

  LoginCubitState copyWith({
    String? email,
    String? password,
    String? password2,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return LoginCubitState(
      email: email ?? this.email,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [email, password, password2, isAuthenticated, errorMessage];
}
