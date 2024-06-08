part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  ScheduleLoaded({
    this.schedules = const [],
  });

  final List<Schedule> schedules;
}

class ScheduleFailure extends ScheduleState {
  ScheduleFailure([this.message = 'Houve um erro ao buscar agenda.']);

  final String message;
}
