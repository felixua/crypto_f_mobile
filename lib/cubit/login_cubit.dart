import 'package:bloc/bloc.dart';
import 'package:crypto_f_mobile/firebase/auth_service.dart';
import 'package:equatable/equatable.dart';

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

  void logInWithCredentials() {
    try {
      _authService
          .signInEmailAndPassword(email: state.email, password: state.password)
          .whenComplete(() =>
              emit(state.copyWith(isAuthenticated: true, errorMessage: "")));
    } catch (_) {
      emit(state.copyWith(
          isAuthenticated: false, errorMessage: _authService.errorMessage));
    }
  }

  void logInWithGoogle() {
    try {
      _authService.signInWithGoogle().whenComplete(
          () => emit(state.copyWith(isAuthenticated: true, errorMessage: "")));
    } catch (_) {
      emit(state.copyWith(
          isAuthenticated: false, errorMessage: _authService.errorMessage));
    }
  }

  void signOut() {
    _authService.signOut().whenComplete(
        () => emit(state.copyWith(isAuthenticated: false, errorMessage: "")));
  }
}
