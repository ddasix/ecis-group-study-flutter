import 'package:calendar_scheduler/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
            Expanded(
              child: Text(
                '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
                style: textStyle,
              ),
            ),
            Text(
              '$count개',
              style: textStyle,
            ),
            const SizedBox(
              width: 8.0,
            ),
            GestureDetector(
              onTap: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.logout,
                size: 16.0,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
