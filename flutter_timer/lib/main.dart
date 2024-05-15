import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer/app.dart';
import 'package:flutter_timer/timer_observer.dart';

void main() {
  Bloc.observer = const TimerObserver();
  runApp(const TimerApp());
}
