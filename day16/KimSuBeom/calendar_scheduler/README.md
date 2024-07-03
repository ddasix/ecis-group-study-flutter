# 일정관리 V3
## 사전지식
### 상태관리
- State Management
    - 최상위 위젯에서 최하위 위젯으로 값을 넘겨 주려면 중간 위젯이 모두 값을 가지고 있어야 함
    - 글로벌 상태 관리 툴로 목표 위젯에서 직접적으로 데이터를 가져옴
    - BloC, GetX, 리버팟Riverpod, 프로바이더Provider 등

### 캐시와 긍정적인 응답
- 캐싱 : 데이터를 기억
    - ScheduleProvider 의 cache 변수
    - GET 메서드로 불러온 모든 일정 정보가 담겨 있음
    - 같은 날짜를 다시 요청할 때는 데이터를 지연 없이 불러옴
- 긍정적 응답
    - 응답이 성공적일 거라는 예측을 하고 UI를 업데이트

## 구현하기
### REST API 용 모델 구현하기
- JSON 형식 그대로 fromJson 생성자에 넣어주면 ScheduleModel에 매핑
- toJson() 은 반대
- copyWith() : 이미 존재하는 인스턴스에서 몇개의 값만 변경하고 싶은 경우

### API 요청 기능 구현하기
- GET : 가져 오고 싶은 일정의 날짜를 'date' 쿼리 파라미터에 입력
    - 리스트로 된 ScheduleModel 을 JSON 형식으로 반환
- POST : 생성하고 싶은 ScheduleModel 을 JSON 형식으로 body 에 입력
    - 새로 생성된 ScheduleModel 의 ID 반환
- DELETE : 삭제하고 싶은 일정의 ID를 'id' body 값에 입력
    - 삭제된 ScheduleModel의 ID 반환

### 글로벌 상태관리 구현 ScheduleProvider
- 프로바이더
    - ChangeNotifier 클래스를 상속하면 어떤 클래스든 프로바이더로 상태 관리 하도록 만들 수 있음
- ScheduleProvider
    - ScheduleRepository
    - 선택한 날짜를 저장하는 selectedDate
    - API 요청을 통해서 받아온 일정 정보를 저장할 cache 변수
    - 일반 클래스처럼 기능을 정의하고 해당 기능들을 위젯에서 실행
    - cache 변수가 업데이트 될 때마다 notifyListener() 함수로 위젯 다시 빌드

### 프로바이더 초기화하기
- 프로젝트 최상위에서 초기화 하면 최하단 위젯까지 모두 속성 사용 가능
- create 와 child 매개변수 제공

### 드리프트를 프로바이더로 대체하기
- StreamBuilder 를 watch() 와 read() 로 대체
- watch() : notifyListeners() 함수가 실행될 때마다 build() 함수를 재실행
    - 한 변수의 값에 따라 UI를 다르게 보여줘야 하는 경우
- read() : FutureBuilder 와 유사하며 단발성으로 값을 가져올때 사용
    - 버튼 탭 같은 특정 액션 후에 값을 가져올 때
- 프로바이더를 사용하면 StatefulWidget 을 사용할 필요가 없음

### 캐시 적용하기
- 긍정적 응답의 적용
    - 서버에서 응답을 받기 전에 캐시를 먼저 업데이트