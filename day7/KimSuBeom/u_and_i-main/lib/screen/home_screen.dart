import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.pink[100], //배경색
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDAY(
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }

  void onHeartPressed() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }
}

//상단 부분 DDAY 위젯
class _DDAY extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  _DDAY({
    required this.onHeartPressed,
    required this.firstDay,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'U&I',
          style: textTheme.displayLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        IconButton(
            onPressed: onHeartPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            )),
        const SizedBox(
          height: 16,
        ),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: textTheme.displayMedium,
        ),
      ],
    );
  }
}

//하단부분 커플이미지 위젯
class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Center(
        child: Image.asset(
          "asset/img/middle_image.png",
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
