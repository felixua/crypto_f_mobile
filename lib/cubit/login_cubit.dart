import 'package:bloc/bloc.dart';
import 'package:crypto_f_mobile/firebase/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final AuthService _authService;
  LoginCubit(this._authService) : super(LoginCubitState());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value.toString().trim(),
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value.toString().trim(),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    try {
      await _authService.signInEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(isAuthenticated: true, errorMessage: ""));
    } catch (_) {
      emit(state.copyWith(
          isAuthenticated: false, errorMessage: _authService.errorMessage));
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
      emit(state.copyWith(isAuthenticated: true, errorMessage: ""));
    } catch (_) {
      emit(state.copyWith(
          isAuthenticated: false, errorMessage: _authService.errorMessage));
    }
  }
}
