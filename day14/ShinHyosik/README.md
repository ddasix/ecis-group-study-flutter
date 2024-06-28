# 일정관리 앱

## `table_calendar` 플러그인
- 달력 구현을 쉽게 해주는 플러그인
```dart
...
TableCalendar(
    focusDay: DateTime.now(),
    firstDay: DateTime(1900, 1, 1),
    lastDay: DateTime(2999, 12, 31),
    selectedDayPredicate: (DateTime day) {  // 선택된 날짜 인식하는 함수
        final now = DateTime.now();

        return DateTime(day.year, day.month, day.day).asAtSameMonentAs(
            DateTime(now.year, now.month, now.day)
        );
    },
    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {},  // 날짜 선택 이벤트
    onPageChanged: (DateTime focusedDay) {},  // 날짜 페이지 변경 이벤트
    rangeSelectionMode: RangeSelectionMode.toggleOff,   // 기간선택 모드 On/Off
    onRangeSelected: (DateTime start, DataTime end, DateTime focusedDay) {},    // 기간 선택 시 이벤트
),
...
```
