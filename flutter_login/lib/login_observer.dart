import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class LoginObserver extends BlocObserver {
  const LoginObserver();

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint("${bloc.runtimeType} $transition");
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint("${bloc.runtimeType} $error");
    super.onError(bloc, error, stackTrace);
  }
}
