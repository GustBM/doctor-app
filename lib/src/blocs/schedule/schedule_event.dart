part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class ScheduleFetch extends ScheduleEvent {
  const ScheduleFetch({
    required this.token,
    required this.iniDate,
    required this.endDate,
  });

  final String token;
  final String iniDate;
  final String endDate;

  @override
  List<Object> get props => [token, iniDate, endDate];
}

class ScheduleInit extends ScheduleEvent {
  const ScheduleInit({
    required this.iniDate,
    required this.endDate,
  });

  final String iniDate;
  final String endDate;

  @override
  List<Object> get props => [iniDate, endDate];
}

class ScheduleRefresh extends ScheduleEvent {
  const ScheduleRefresh({
    required this.iniDate,
    required this.endDate,
  });

  final String iniDate;
  final String endDate;

  @override
  List<Object> get props => [iniDate, endDate];
}
