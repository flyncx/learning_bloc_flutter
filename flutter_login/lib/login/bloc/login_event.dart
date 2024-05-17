part of "login_bloc.dart";

sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged({required this.username});

  final String username;

  @override
  List<Object?> get props => [...super.props, username];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [...super.props, password];
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
