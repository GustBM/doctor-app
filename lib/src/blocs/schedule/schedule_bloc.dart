import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:medic_repository/medic_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required MedicRepository medicRepository,
  })  : _medicRepository = medicRepository,
        super(ScheduleLoaded()) {
    on<ScheduleInit>(_onScheduleInit);
    on<ScheduleRefresh>(_onScheduleRefresh);
  }

  final MedicRepository _medicRepository;

  Future<void> _onScheduleInit(
    ScheduleInit event,
    Emitter<ScheduleState> emit,
  ) async {
    List<Schedule>? schedules;
    emit(ScheduleLoading());
    try {
      schedules = await _medicRepository.getSchedule(
        dateStart: event.iniDate,
        dateEnd: event.endDate,
      );
    } catch (e) {
      emit(ScheduleFailure(e.toString()));
      return;
    }

    emit(ScheduleLoaded(schedules: schedules ??= []));
  }

  Future<void> _onScheduleRefresh(
    ScheduleRefresh event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    await Future.delayed(
      const Duration(seconds: 4),
    );
    emit(ScheduleLoaded());
  }
}
