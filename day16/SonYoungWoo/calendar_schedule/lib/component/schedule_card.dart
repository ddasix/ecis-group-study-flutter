import 'package:flutter/material.dart';
import 'package:calendar_schedule/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  const ScheduleCard({
    super.key
, required this.startTime, required this.endTime, required this.content});

  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
         border: Border.all(
           width: 1.0,
           color: PRIMARY_COLOR,
         ),
         borderRadius: BorderRadius.circular(8.0),
       ),
       child: Padding(
         padding: const EdgeInsets.all(16),
         child: IntrinsicHeight( //높이를 내부 위젯 최대 높이로
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               _Time(startTime: startTime, endTime: endTime),
               SizedBox(width: 16,),
               _Content(content: content),
               SizedBox(width: 16,)
             ],
           ),
         ),
       ),
     );
  }

}

class _Time extends StatelessWidget {

  final int startTime;
  final int endTime;

  const _Time({super.key,
   required this.startTime,
    required this.endTime});

  @override
  Widget build(BuildContext context) {
   final textStyle = TextStyle(
     fontWeight: FontWeight.w600,
     color: PRIMARY_COLOR,
     fontSize: 16.0
   );

   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text( //숫자가 2자리 안되면 앞에 0
         "${startTime.toString().padLeft(2,"0")}:00",
         style: textStyle,
       ),
       Text( //숫자가 2자리 안되면 앞에 0
         "${endTime.toString().padLeft(2,"0")}:00",
         style: textStyle.copyWith(
           fontSize: 10.0,
         ),
       ),
     ],
   );
  }

}

class _Content extends StatelessWidget {
  final String  content; //내용
  const _Content({super.key,required this.content});

  @override
  Widget build(BuildContext context) {
   return Expanded(
       child: Text(
         content
       ));
  }
}