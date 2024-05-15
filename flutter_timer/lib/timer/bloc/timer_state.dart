part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState(this.seconds);
  final int seconds;

  @override
  List<Object?> get props => [seconds];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.seconds);

  @override
  String toString() => 'TimerInitial { seconds: $seconds }';
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.seconds);

  @override
  String toString() => 'TimerRunPause { seconds: $seconds }';
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.seconds);

  @override
  String toString() => 'TimerRunInProgress { seconds: $seconds }';
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
