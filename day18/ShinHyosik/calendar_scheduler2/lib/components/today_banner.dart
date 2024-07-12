import 'package:calendar_scheduler/constants/colors.dart';
import 'package:calendar_scheduler/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int count;

  const TodayBanner({
    super.key,
    required this.selectedDay,
    required this.count,
  });

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
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: textStyle,
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    '$count개',
                    style: textStyle,
                  ),
                  const SizedBox(width: 8.0,),
                  GestureDetector(
                    onTap: () {
                      provider.logout();
              
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
