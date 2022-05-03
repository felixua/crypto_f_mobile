import 'package:bloc/bloc.dart';
import 'package:crypto_f_mobile/firebase/auth_service.dart';
import 'package:equatable/equatable.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  final AuthService _authService;
  LoginCubit(this._authService) : super(LoginCubitState());

  void emailChanged(String value) {
    emit(
      state.copyWith(email: value.toString().trim(), errorMessage: ""),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: value.toString().trim(), errorMessage: ""),
    );
  }

  void password2Changed(String value) {
    emit(
      state.copyWith(password2: value.toString().trim(), errorMessage: ""),
    );
  }

  void signUp() {
    if (state.password == state.password2) {
      _authService
          .signUp(email: state.email, password: state.password)
          .then((res) {
        if (res) {
          emit(state.copyWith(
              isAuthenticated: false,
              errorMessage: "User ${state.email} created successfuly"));

          _authService
              .signInEmailAndPassword(
                  email: state.email, password: state.password)
              .then((res) => {
                    if (res)
                      emit(state.copyWith(
                          isAuthenticated: true, errorMessage: ""))
                    else
                      emit(state.copyWith(
                          isAuthenticated: false,
                          errorMessage: _authService.errorMessage))
                  })
              .catchError((_) {
            emit(state.copyWith(
                isAuthenticated: false,
                errorMessage: _authService.errorMessage));
          });
        } else {
          emit(state.copyWith(
              isAuthenticated: false, errorMessage: _authService.errorMessage));
        }
      }).catchError((_) {
        emit(state.copyWith(
            isAuthenticated: false, errorMessage: _authService.errorMessage));
      });
    } else {
      emit(state.copyWith(
          isAuthenticated: false,
          errorMessage: "Password confirmation doesn't match"));
    }
  }

  void logInWithCredentials() {
    _authService
        .signInEmailAndPassword(email: state.email, password: state.password)
        .then((res) => {
              if (res)
                emit(state.copyWith(isAuthenticated: true, errorMessage: ""))
              else
                emit(state.copyWith(
                    isAuthenticated: false,
                    errorMessage: _authService.errorMessage))
            })
        .catchError((err) {
      emit(state.copyWith(
          isAuthenticated: false, errorMessage: _authService.errorMessage));
    });
  }

  void logInWithGoogle() {
    _authService
        .signInWithGoogle()
        .then((res) => {
              if (res)
                emit(state.copyWith(isAuthenticated: true, errorMessage: ""))
              else
                emit(state.copyWith(
                    isAuthenticated: false,
                    errorMessage: _authService.errorMessage))
            })
        .catchError((e) {
      emit(state.copyWith(
          isAuthenticated: false, errorMessage: _authService.errorMessage));
    });
  }

  void signOut() {
    _authService.signOut().whenComplete(
        () => emit(state.copyWith(isAuthenticated: false, errorMessage: "")));
  }
}
