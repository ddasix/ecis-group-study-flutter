class ScheduleModel {

  final String id;
  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;

  ScheduleModel({
    required this.id, required this.content, required this.date, required this.startTime, required this.endTime
    });

  //json으로 모델 생성
  ScheduleModel.fromJson({
    required Map<String, dynamic> json,
}) : id = json["id"],
     content = json["content"],
     date = DateTime.parse(json["date"]),
     startTime = json["startTime"],
     endTime = json["endTime"];

  //모델에서 json 생성
   Map<String,dynamic> toJson(){
     return {
       "id": id,
       "content":content,
       "date": "${date.year}${date.month.toString().padLeft(2,"0")}${date.day.toString().padLeft(2,"0")}",
       "startTime" : startTime,
       "endTime" : endTime,
     };
   }

   //copywith를 사용하여 특정 속성만 변환해서 새로 생성
   ScheduleModel copyWith({
    String? id,
    String? content,
    DateTime? date,
    int? startTime,
    int? endTime,
}) {
     return ScheduleModel(
       id: id ?? this.id,
       content: content ?? this.content,
       date : date ?? this.date,
       startTime: startTime ?? this.startTime,
       endTime: endTime ?? this.endTime
     );
   }


}