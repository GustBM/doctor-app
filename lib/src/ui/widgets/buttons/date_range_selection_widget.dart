import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeSelectionWidget extends StatefulWidget {
  const DateRangeSelectionWidget(
      {super.key,
      this.restorationId,
      required this.setDateTimeRangeFunction,
      required this.iniData,
      required this.endData});

  final String? restorationId;
  final String iniData;
  final String endData;
  final Function(DateTimeRange?) setDateTimeRangeFunction;

  @override
  State<DateRangeSelectionWidget> createState() =>
      _DateRangeSelectionWidgetState();
}

class _DateRangeSelectionWidgetState extends State<DateRangeSelectionWidget>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate =
      RestorableDateTimeN(DateTime.now().add(const Duration(days: 7)));
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
        widget.setDateTimeRangeFunction(newSelectedDate);
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(DateTime.now().year - 2),
          currentDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 2),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          _restorableDateRangePickerRouteFuture.present();
        },
        child: Text(
          '${widget.iniData} - ${widget.endData}',
          style: const TextStyle(fontSize: 16),
        ));
  }
}
