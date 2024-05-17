import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/login/models/models.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(value: event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([
          username,
          state.password,
        ]),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(value: event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          password,
          state.username,
        ]),
      ),
    );
  }

  FutureOr<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signin(
            username: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
