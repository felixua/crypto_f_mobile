part of 'login_cubit.dart';

class LoginCubitState extends Equatable {
  final String email;
  final String password;
  String errorMessage;
  bool isAuthenticated;

  LoginCubitState(
      {this.email = "",
      this.password = "",
      this.isAuthenticated = false,
      this.errorMessage = ""});

  LoginCubitState copyWith({
    String? email,
    String? password,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return LoginCubitState(
      email: email ?? this.email,
      password: password ?? this.password,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, isAuthenticated, errorMessage];
}
