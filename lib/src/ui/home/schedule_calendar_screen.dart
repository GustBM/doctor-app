import 'package:doctor247_doutor/src/blocs/schedule/schedule_bloc.dart';
import 'package:doctor247_doutor/src/models/calendar_meeting.dart';
import 'package:doctor247_doutor/src/ui/widgets/cards/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medic_repository/medic_repository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../utils.dart';

class ScheduleCalendarScreen extends StatefulWidget {
  const ScheduleCalendarScreen({super.key});

  @override
  State<ScheduleCalendarScreen> createState() => _ScheduleCalendarScreenState();
}

class _ScheduleCalendarScreenState extends State<ScheduleCalendarScreen> {
  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    final now = DateTime.now();
    var monthBegin =
        DateTime(now.year, now.month, 1).subtract(const Duration(days: 7));
    var monthEnd =
        DateTime(now.year, now.month + 1, 0).add(const Duration(days: 7));
    BlocProvider.of<ScheduleBloc>(context).add(ScheduleInit(
      iniDate: apiDateFormat.format(monthBegin),
      endDate: apiDateFormat.format(monthEnd),
    ));
    super.initState();
  }

  DataSource _getCalendarDataSource(List<Schedule> schedules) {
    List<Appointment> appointments = <Appointment>[];

    for (var consultation in schedules) {
      appointments.add(Appointment(
        startTime: consultation.getScheduleDateDateTime,
        endTime: consultation.getScheduleDateDateTime.add(
          const Duration(hours: 2),
        ),
        subject: consultation.paciente.name,
        recurrenceId: consultation,
        startTimeZone: '',
        endTimeZone: '',
      ));
    }
    return DataSource(appointments);
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;
    return ScheduleCard(consultation: appointment.recurrenceId as Schedule);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoaded) {
          return Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 620,
                child: SfCalendar(
                  controller: _controller,
                  view: CalendarView.month,
                  initialSelectedDate: DateTime.now(),
                  showNavigationArrow: true,
                  dataSource: _getCalendarDataSource(state.schedules),
                  appointmentBuilder: appointmentBuilder,
                  timeSlotViewSettings:
                      const TimeSlotViewSettings(timelineAppointmentHeight: 50),
                  monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    agendaItemHeight: 120,
                    numberOfWeeksInView: 5,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator,
                    showTrailingAndLeadingDates: false,
                  ),
                ),
              ),
            ],
          );
        } else if (state is ScheduleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ScheduleFailure) {
          return SnapshotErroMsg(state.message);
        } else {
          return const Text('Erro');
        }
      },
    );
  }
}
