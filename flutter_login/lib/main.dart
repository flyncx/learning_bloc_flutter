import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app.dart';
import 'package:flutter_login/login_observer.dart';

void main() {
  Bloc.observer = const LoginObserver();
  runApp(const LoginApp());
}
