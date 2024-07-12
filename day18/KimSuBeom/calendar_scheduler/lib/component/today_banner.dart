import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count;

  const TodayBanner(
      {super.key, required this.selectedDate, required this.count});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    const textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일'),
            Row(
              children: [
                Text(
                  '$count개',
                  style: textStyle,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                GestureDetector(
                  onTap: () {
                    provider.logout();

                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 16.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
