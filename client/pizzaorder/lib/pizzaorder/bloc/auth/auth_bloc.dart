import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_event.dart';
import 'package:pizzaorder/pizzaorder/bloc/auth/auth_state.dart';
import 'package:pizzaorder/pizzaorder/services/user_service.dart';
import 'package:pizzaorder/pizzaorder/models/user.dart';
import 'package:pizzaorder/pizzaorder/bloc/Result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService _userService;

  AuthBloc(this._userService) : super(AuthInitial()) {
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthRegisterStarted>(_onRegisterStarted);
    on<AuthLogoutStarted>(_onLogoutStarted);
    // on<AuthLoginWithGoogle>(_onLoginWithGoogle);
  }

  Future<void> _onLoginStarted(
      AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());
    try {
      final result = await _userService.login(event.username, event.password);
      if (result is Success<UserModel>) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result.data.token!);
        emit(AuthLoginSuccess());
      } else if (result is Failure) {
        emit(AuthLoginFailure(result.message));
      } else {
        emit(AuthLoginFailure('Unexpected error'));
      }
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onRegisterStarted(
      AuthRegisterStarted event, Emitter<AuthState> emit) async {
    emit(AuthRegisterInProgress());
    try {
      await Future.delayed(const Duration(seconds: 3));
      final result = await _userService.register(event.username, event.password,
          event.nameProfile, event.phone, event.email, event.address);
      if (result is Success<UserModel>) {
        emit(AuthRegisterSuccess());
      } else if (result is Failure) {
        emit(AuthRegisterFailure(result.message));
      } else {
        emit(AuthRegisterFailure('Unexpected error'));
      }
    } catch (e) {
      emit(AuthRegisterFailure(e.toString()));
    }
  }

  Future<void> _onLogoutStarted(
      AuthLogoutStarted event, Emitter<AuthState> emit) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    emit(AuthLogoutSuccess());
  }
}
