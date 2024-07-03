import 'package:flutter/material.dart';
import 'package:calendar_schedule/component/custom_text_field.dart';
import 'package:calendar_schedule/const/colors.dart';
//material.dart 의 Colum과 중복되어서 숨김
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:calendar_schedule/database/drift_database.dart';
import 'package:path/path.dart';

import 'package:provider/provider.dart';
import 'package:calendar_schedule/model/schedule_model.dart';
import 'package:calendar_schedule/provider/schedule_provider.dart';

class ScheduleBottomSheet extends StatefulWidget {

  final DateTime selectedDate;

  const ScheduleBottomSheet({super.key, required this.selectedDate});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();

}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet>{

   final GlobalKey<FormState> formKey = GlobalKey();
   int? startTime;
   int? endTime;
   String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
      child: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height /2 + bottomInset,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8,bottom: bottomInset),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          label: "시작 시간",
                          isTime: true,
                          onSaved: (String? val){
                            startTime = int.parse(val!);
                          },
                          validator: timeValidator,
                        )),
                        const SizedBox(width: 16,),
                        Expanded(child: CustomTextField(
                          label: "종료 시간",
                          isTime: true,
                          onSaved: (String? val){
                            endTime = int.parse(val!);
                          },
                          validator: timeValidator,
                        ))
                      ],
                    ),
                    SizedBox(height: 8,),
                    Expanded(child: CustomTextField(
                      label: "내용",
                      isTime: false,
                      onSaved: (String? val){
                        content = val;
                      },
                      validator: contentValidator,
                    )),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: ()=> onSavePressed(context), //프로바이더로 변경-context전달
                        child: Text("저장"),
                      ),
                    )
                  ],
                ),
              )
          )),
    );

  }

void onSavePressed(BuildContext context) async {
    //form서브에 있는 모든 TextFormField validate 검증
    if(formKey.currentState!.validate()){
      formKey.currentState!.save(); //모든 TextFormField들의 onSaved 매개 변수에 입력된 함수 실행
/*
      await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
             startTime: Value(startTime!),
             endTime: Value(endTime!),
             content: Value(content!),
             date: Value(widget.selectedDate),
          ),
      );
*/
      context.read<ScheduleProvider>().createSchduels(
          schedule: ScheduleModel(
            id: "tmp_id",//서버에서 자동 생성된 값으로 대체
            content: content!,
            date: widget.selectedDate,
            startTime: startTime!,
            endTime: endTime!,
          ),);

      Navigator.of(context).pop(); //일정생성 후 뒤로 가기
    }
}

String? timeValidator(String? val) {

  if (val == null) {
    return '값을 입력해주세요';
  }

  int? number;

  try {
    number = int.parse(val);
  } catch (e) {
    return '숫자를 입력해주세요';
  }

  if (number < 0 || number > 24) {
    return '0시부터 24시 사이를 입력해주세요';
  }

}

String? contentValidator(String? val) {

  if (val == null || val.length == 0) {
    return '값을 입력해주세요';
  }
  return null;
}
}