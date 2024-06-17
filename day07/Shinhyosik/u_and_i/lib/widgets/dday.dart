import 'package:flutter/material.dart';

class DDay extends StatelessWidget {
  final GestureTapCallback onPressed;
  final GestureTapCallback onCalendarPressed;
  final DateTime firstDay;

  const DDay({
    super.key,
    required this.onPressed,
    required this.firstDay,
    required this.onCalendarPressed,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          'U&I',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          '우리 처음 만난 날',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: onCalendarPressed,
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
