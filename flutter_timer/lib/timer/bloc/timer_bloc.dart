import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_timer/ticker.dart';
part 'timer_state.dart';
part 'timer_event.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const _initSeconds = 60;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  TimerBloc()
      : _ticker = Ticker(),
        super(const TimerInitial(_initSeconds)) {
    on<TimerStarted>(_handleOnStarted);
    on<TimerTicked>(_handleOnTicked);
    on<TimerPaused>(_handleOnPaused);
    on<TimerResumed>(_handleOnResumed);
    on<TimerReset>(_handleOnReset);
  }

  FutureOr<void> _handleOnStarted(
      TimerStarted event, Emitter<TimerState> emit) async {
    emit(TimerRunInProgress(event.seconds));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(seconds: event.seconds).listen(
          (duration) => add(TimerTicked(seconds: duration)),
        );
  }

  FutureOr<void> _handleOnTicked(
      TimerTicked event, Emitter<TimerState> emit) async {
    emit(
      event.seconds > 0
          ? TimerRunInProgress(event.seconds)
          : const TimerRunComplete(),
    );
  }

  FutureOr<void> _handleOnPaused(
      TimerPaused event, Emitter<TimerState> emit) async {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.seconds));
    }
  }

  FutureOr<void> _handleOnResumed(
      TimerResumed event, Emitter<TimerState> emit) async {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.seconds));
    }
  }

  FutureOr<void> _handleOnReset(
      TimerReset event, Emitter<TimerState> emit) async {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_initSeconds));
  }
}
