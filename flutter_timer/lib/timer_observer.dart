import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class TimerObserver extends BlocObserver {
  const TimerObserver();
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint("${bloc.runtimeType} $change");
  }
}
