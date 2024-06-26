part of "authentication_bloc.dart";

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user = User.empty});

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  String toString() {
    return "AuthenticationState { status: $status, user: $user }";
  }
}
