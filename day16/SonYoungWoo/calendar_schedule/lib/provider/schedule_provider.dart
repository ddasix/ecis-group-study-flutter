
import 'package:flutter/material.dart';
import 'package:calendar_schedule/model/schedule_model.dart';
import 'package:calendar_schedule/repository/schedule_repository.dart';
import 'package:uuid/uuid.dart';


class ScheduleProvider extends ChangeNotifier {

  //API 요청 클래스
  final ScheduleRepository repository;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day
  );


  Map<DateTime, List<ScheduleModel>> cache = {}; //일정 정보 저장

 ScheduleProvider({
  required  this.repository,
}) : super() {
   getSchdules(date:selectedDate);
 }

 //일정 조회
 void getSchdules({required DateTime date}) async {
   final resp = await repository.getSchedules(date: date);

   cache.update(date,(v)=> resp, ifAbsent: ()=> resp);

   notifyListeners(); //참조하는 모든 위젯들의 bulid 함수 재실행
 }

 //일정 추가
 void createSchduels({
    required ScheduleModel schedule,
}) async {
   final targetDate = schedule.date;

   final saveSchdule = await repository.createSchedule(schedule: schedule);

   final uuid = Uuid();
   final tempId = uuid.v4();
   final newSchedule = schedule.copyWith(id: tempId,);


   cache.update(
       targetDate,
       (v)=> [
         ...v,
         newSchedule,]..sort((a,b)=> a.startTime.compareTo(b.startTime,),
   ),
   ifAbsent: () => [newSchedule],
   );

   notifyListeners();

   try{

     final savedSchedule = await repository.createSchedule(schedule: schedule);

     cache.update(
         targetDate,
         (v)=>v.map((e)=> e.id == tempId ? e.copyWith(id: savedSchedule,):e).toList(),);
   }catch(e) {

   }
 }

 //일정 삭제
 void deleteSchedule({
    required DateTime date,
    required String id,
}) async {

   final resp = await repository.deleteSchedule(id: id);

   cache.update(
       date,
       (v) => v.where((e) => e.id != id).toList(),
      ifAbsent: () => [],);

 }

 //선택 일자 변경
 void changeSelectedDate({
    required DateTime date,
}) {
   selectedDate = date;
   notifyListeners();
 }

}