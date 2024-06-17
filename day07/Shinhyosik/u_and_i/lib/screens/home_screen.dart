import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_and_i/widgets/couple_image.dart';
import 'package:u_and_i/widgets/dday.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var firstDay = DateTime.now();

  void onHeartPressed() {
    setState(() {
      firstDay = firstDay.subtract(const Duration(days: 1));
    });
  }

  void onCalendarPressed(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          height: 300,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              setState(() {
                firstDay = value;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DDay(
              firstDay: firstDay,
              onPressed: onHeartPressed,
              onCalendarPressed: () => onCalendarPressed(context),
            ),
            CoupleImage()
          ],
        ),
      ),
    );
  }
}
