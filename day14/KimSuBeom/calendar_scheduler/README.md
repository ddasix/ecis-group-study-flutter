# 일정관리
## 사전지식
### table_calendar 플러그인
- focusedDay : 포커스된 날짜
- firstDay : 달력의 제일 첫 번째 날짜
- lastDay : 달력의 제일 마지막 날짜
- selectedDayPredicate : 선택된 날짜를 인식하는 함수
- onDaySelected : 날짜가 선택됐을 때 실행할 함수
- onPageChaned : 날짜가 변경됐을 때 실행할 함수
- rangeSelectionMode : 기간 선택 모드
- onRangeSelected : 기간이 선택됐을 떄 실행할 함수

## 사전 준비
### pubspec.yaml
- dev_dependencies : 개발할 때만 사용되고 앱과 함께 패키징 되지는 않음
- 드리프트Drift : SQLite 데이터베이스를 구현할 수 있는 플러그인
- 코드 생성 code generation : 자동으로 코드를 작성하는 기능

```dart
table_calendar: 3.1.2           # 달력
intl: 0.19.0                    # 다국어화 기능
drift: 2.18.0                   # Drift ORM 
sqlite3_flutter_libs: 0.5.24    # SQLite 데이터베이스
path_provider: 2.1.3            # 파일 시스템 경로를 쉽게 얻을 수 있도록
path: 1.9.0                     # 경로 조작을 쉽게 할 수 있게
get_it: 7.7.0                   # 프로젝트 전역으로 의존성 주입을 가능
dio: 5.4.3+1                    # 네트워크 요청
provider: 6.1.2                 # 글로벌 상태 관리
uuid: 4.4.0                     # UUID 생성

drift_dev: 2.18.0               # Drift 코드 생성 기능 관련
build_runner: 2.4.11            # 플러터 코드 생성 기능 제공
```

## 레이아웃
### 홈 스크린
- 달력과 리스트 2등분
- 달력에서 날짜를 선택하면 일정 리스트가 나타남
- 달력과 리스트 사이 일정 개수가 있는 배너가 있음
- 플로팅 액션 버튼으로 일정 추가 버튼

### ScheduleBottomSheet
- 일정을 추가하거나 수정할 때 사용하는 위젯
- 일정 시작 시간과 종료 시간을 지정할 수 있는 시간 텍스트 필드
- 일정 내용을 작성할 수 있는 내용 텍스트 필드
- 저장 버튼

## 구현
### 주색상 설정
- 주색상 초록색, 옅은 회색, 어두운 회색
- 텍스트 필드 배경색

### 달력 구현
- table_calendar 플러그인
    - firstDay, lastDay, focusedDay 필수 입력
- 달력 스타일링
    - 화살표, 년 월 : headerStyle
    - 날짜 : calendarStyle
- OnDaySelected 타입 : 플러그인 기본 제공 typedef

### 선택된 날의 일정 보여주기 : ScheduleCard 위젯
- 시간 영역과 내용 영역으로 구성
- 시간 영역
    - 시작 시간과 종료 시간은 외부에서 입력
    - 시작 시간이 위, 종료 시간이 아래로 Column 배치
- 내용 영역
    - 부모 위젯에서 내용을 String 입력
    - Expanded 로 좌우 최대
- IntrinsicHeight 위젯 
    - 내부 위젯들의 높이를 최대 높이로 맞춤
    - _Time 과 _Content 위젯의 높이를 동일하게

### 오늘 날짜를 보여주기 : TodayBanner 위젯
- 달력과 스케쥴카드 사이에 오늘 날짜 표시
    - 선택된 날짜와 해당 날짜에 해당하는 일정 개수

### 일정 입력
- ScheduleBottomSheet : 사용자가 새로 추가할 일정 입력
- 텍스트 필드 3개와 버튼 하나
    - 시작 시간, 종료 시간, 일정 내용 필드
    - 저장 버튼
- floatingActionButton 
    - showModalBottomSheet 함수로 실행
        - isDismissible 로 배경 클릭시 닫힘

### 일정 내용 필드 구현
- TextFormField : 여러개의 텍스트 필드를 하나의 폼으로 제어
    - maxLines : 허락되는 최대 줄 개수
        - null 시 제한 없음
    - expands : 텍스트 필드를 부모 위젯 크기만큼 세로로 늘림
        - false 시 최소 크기만
    - inputFormatters : 텍스트 필드 입력 제한
    - suffix : 접미사 지정
- 키보드가 화면에 나오면 그만큼 아래에 패딩 추가
    - MediaQuery 의 viewInsets. : 시스템이 차지하는 화면 아랫부분 크기

### 달력 언어 설정
- intl 패키지