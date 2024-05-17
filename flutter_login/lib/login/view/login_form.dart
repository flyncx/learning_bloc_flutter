import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  final _spacer = const Padding(padding: EdgeInsets.all(12));

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text("Authentication Failure")));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            _spacer,
            _PasswordInput(),
            _spacer,
            _LoginButton()
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm-usernameInput-textField"),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginUsernameChanged(username: value)),
          decoration: InputDecoration(
              labelText: "Username",
              errorText: state.username.displayError != null
                  ? "Invalid username"
                  : null),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key("loginForm-passwordInput-textField"),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
          obscureText: true,
          decoration: InputDecoration(
              labelText: "Password",
              errorText: state.password.displayError != null
                  ? "Invalid password"
                  : null),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text("Login"),
              );
      },
    );
  }
}
