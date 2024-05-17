import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  void dispose() {
    _controller.close();
  }

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> signin(
      {required String username, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _controller.add(AuthenticationStatus.unauthenticated);
  }
}
