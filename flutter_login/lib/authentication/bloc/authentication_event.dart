part of "authentication_bloc.dart";

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object?> get props => [status];
}

final class AuthenticationSignoutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
