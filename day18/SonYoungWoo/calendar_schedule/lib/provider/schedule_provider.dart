
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

   final uuid = Uuid();
   final tempId = uuid.v4();
   final newSchedule = schedule.copyWith(id: tempId,);

   //서버에서 응답받기 전 캐시를 먼저 업데이트
   cache.update(
       targetDate,
       (v)=> [
         ...v,
         newSchedule,]..sort((a,b)=> a.startTime.compareTo(b.startTime,),
   ),
   ifAbsent: () => [newSchedule],
   );

   //업데이트 반영
   notifyListeners();

   try{

     final savedSchedule = await repository.createSchedule(schedule: schedule);

     //실제 서버에서 받아온 후 업데이트
     cache.update(
         targetDate,
         (v)=>v.map((e)=> e.id == tempId ? e.copyWith(id: savedSchedule,):e).toList(),);
   }catch(e) {

     //실패하면 캐시에서 삭제
    cache.update(targetDate,
        (v)=> v.where((e)=>e.id!=tempId).toList(),
    );

   }
   //업데이트 반영
   notifyListeners();
 }

 //일정 삭제
 void deleteSchedule({
    required DateTime date,
    required String id,
}) async {

   //삭제할 일정 기억
   final targetSchedule = cache[date]!.firstWhere((e)=>e.id == id);

   //캐시에서 미리 삭제
   cache.update(
     date,
         (v) => v.where((e) => e.id != id).toList(),
     ifAbsent: () => [],);

   //캐시 업데이트
   notifyListeners();

   try{
     //서버에서 삭제
     await repository.deleteSchedule(id: id);
   }
   catch(e){
     //삭제 실패시
     cache.update(date,
         (v)=>[...v,targetSchedule]..sort((a,b)=> a.startTime.compareTo(b.startTime,
         ),
         ),
     );
   }

         //캐시 업데이트
         notifyListeners();

 }

 //선택 일자 변경
 void changeSelectedDate({
    required DateTime date,
}) {
   selectedDate = date;
   notifyListeners();
 }

}