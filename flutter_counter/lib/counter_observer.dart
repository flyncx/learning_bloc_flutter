import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CounterObserver extends BlocObserver {
  const CounterObserver();
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint("${bloc.runtimeType} $change");
  }
}
