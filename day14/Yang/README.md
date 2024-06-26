# 일정관리 앱 만들기

## 사전 지식


- `Table Calendar` 플러그인: Flutter에서 사용자 정의 가능한 달력 위젯
Table Calendar 플러그인은 Flutter에서 사용자 정의 가능한 달력 위젯을 쉽게 구현할 수 있도록 지원하는 유용한 패키지입니다. 다양한 기능과 옵션을 제공하여 원하는 대로 달력을 디자인하고 사용자 경험을 개선할 수 있습니다.

- Table Calendar 플러그인의 주요 특징:

    -   사용자 정의 가능한 디자인: 테마, 색상, 글꼴, 스타일 등을 원하는 대로 설정할 수 있습니다.
    -   다양한 날짜 표시 옵션: 년, 월, 주, 일별로 날짜를 표시할 수 있습니다.
    - 월 및 연도 탐색: 쉽게 이전/다음 달 또는 연으로 이동할 수 있습니다.
    - 이벤트 표시: 특정 날짜에 이벤트를 표시하고 강조 표시할 수 있습니다.
    - 제스처 지원: 스와이프 및 탭 제스처를 사용하여 달력을 탐색할 수 있습니다.
    - 다국어 지원: 다양한 언어를 지원합니다.
    -   플러터 웹 지원: 웹 앱에서도 사용할 수 있습니다.

![alt text](image-1.png)

- Table Calendar 플러그인은 다음과 같은 다양한 옵션
    - `firstDay`: 표시되는 첫 번째 날짜를 설정합니다.
    - `lastDay`: 표시되는 마지막 날짜를 설정합니다.
    - `onDaySelected`: 날짜를 선택했을 때 호출되는 함수입니다.
    - `selectedDay`: 현재 선택된 날짜를 설정합니다.
    - `focusedDay`: 현재 포커스된 날짜를 설정합니다.
    - `currentDay`: 현재 날짜를 설정합니다.
    - `daysOfWeek`: 요일 이름을 설정합니다.
    - `headerStyle`: 헤더 스타일을 설정합니다.
    - `cellStyle`: 셀 스타일을 설정합니다.
    - `selectedCellStyle`: 선택된 셀 스타일을 설정합니다.
    - `todayCellStyle`: 오늘 셀 스타일을 설정합니다.

### 그외 Calendar 플러그인
- `Day Planner`: 일별 일정 관리 기능을 제공하는 플러그인입니다. 이벤트 추가, 편집, 삭제, 드래그 앤 드롭 이동 등이 가능합니다. https://pub.dev/packages/time_planner

 - `Event Calendar`: 이벤트 표시 및 관리 기능을 제공하는 플러그인입니다. 다양한 이벤트 스타일, 필터링 옵션, 검색 기능을 지원합니다. 
 https://pub.dev/packages/flutter_event_calendar

 - 그외에도 다양한 Flutter 달력 플러그인이 있습니다.