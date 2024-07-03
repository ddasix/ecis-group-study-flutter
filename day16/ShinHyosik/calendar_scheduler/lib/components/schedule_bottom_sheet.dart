import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/models/schedule_model.dart';
import 'package:calendar_scheduler/providers/schedule_provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/components/custom_text_field.dart';
import 'package:calendar_scheduler/constants/colors.dart';
import 'package:provider/provider.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleBottomSheet({
    super.key,
    required this.selectedDate,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? contents;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
              bottom: bottomInset,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '시작 시간',
                        isTime: true,
                        onSaved: (newValue) {
                          startTime = int.parse(newValue!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: CustomTextField(
                        label: '종료 시간',
                        isTime: true,
                        onSaved: (newValue) {
                          endTime = int.parse(newValue!);
                        },
                        validator: timeValidator,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  height: 150,
                  child: CustomTextField(
                    label: '내용',
                    isTime: false,
                    onSaved: (newValue) {
                      contents = newValue;
                    },
                    validator: contentValidator,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onSavePressed(context),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: PRIMARY_COLOR),
                    child: Text('저장'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      print(startTime);
      print(endTime);
      print(contents);
      context.read<ScheduleProvider>().createSchedule(
            schedule: ScheduleModel(
              id: 'new model',
              content: contents!,
              date: widget.selectedDate,
              startTime: startTime!,
              endTime: endTime!,
            ),
          );

      // await GetIt.I<LocalDatabase>().createSchedule(
      //   SchedulesCompanion(
      //     startTime: Value(startTime!),
      //     endTime: Value(endTime!),
      //     content: Value(contents!),
      //     date: Value(widget.selectedDate),
      //   ),
      // );

      Navigator.of(context).pop();
    }
  }

  String? timeValidator(String? value) {
    if (value == null) {
      return '값을 입력해 주세요.';
    }

    int? number;

    try {
      number = int.parse(value);
    } catch (e) {
      return '숫자를 입력해 주세요.';
    }

    if (number < 0 || number > 24) {
      return '0 ~ 24 사이 값을 입력해 주세요.';
    }

    return null;
  }

  String? contentValidator(String? value) {
    if (value == null) {
      return '값을 입력해 주세요.';
    }
    return null;
  }
}
