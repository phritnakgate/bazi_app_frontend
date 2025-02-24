import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class LuckCalendarWidget extends StatefulWidget {
  const LuckCalendarWidget({required this.selectedMonth, super.key});

  final int selectedMonth;

  @override
  State<LuckCalendarWidget> createState() => _LuckCalendarWidgetState();
}

class _LuckCalendarWidgetState extends State<LuckCalendarWidget> {
  int currentYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TableCalendar(
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: fcolor,
            shape: BoxShape.circle,
          ),
        ),
        locale: 'th_TH',
        focusedDay: DateTime(currentYear, widget.selectedMonth + 1, 1),
        firstDay:
            DateTime.utc(DateTime.now().year, widget.selectedMonth + 1, 1),
        lastDay:
            DateTime.utc(DateTime.now().year, widget.selectedMonth + 1, 31),
        availableGestures: AvailableGestures.none,
        headerVisible: false,
        calendarFormat: CalendarFormat.month,
        calendarBuilders:
            CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }),
      ),
    );
  }
}
