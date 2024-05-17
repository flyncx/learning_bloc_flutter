import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';
import 'package:flutter_login/home/view/home_page.dart';
import 'package:user_repository/user_repository.dart';

import 'login/login.dart';
import 'splash/view/splash_page.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginAppState();
  }
}

class _LoginAppState extends State<LoginApp> {
  late final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const LoginAppView(),
      ),
    );
  }
}

class LoginAppView extends StatefulWidget {
  const LoginAppView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginAppViewState();
  }
}

class _LoginAppViewState extends State<LoginAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                    HomePage.route(), (route) => false);
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                    LoginPage.route(), (route) => false);
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (settings) => SplashPage.route(),
    );
  }
}
