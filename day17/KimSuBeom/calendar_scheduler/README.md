# 일정관리 V4
## 사전지식
### 파이어베이스
- 모바일 앱 개발에 최적화된 기능을 제공하는 서비스

### 파이어스토어
- NoSQL 데이터베이스
- 컬랙션collection
    - 테이블에 해당
- 문서document
    - 열row 에 해당
    - 키와 값의 조합
    - 하나의 값이 들어간느 위치에 리스트나 맵 등 완전한 JSON 구조를 통째로 저장
- 파이어 스토어 문서 삽입
    - FirebaseFirestore.instance    
    - add() : 자동으로 문서의 ID 값을 생성
        - collection() : 문서를 저장할 컬랙션 지정
        - 매개변수에 Map 형태의 데이터 입력
    - set() : 직접 문서의 ID 값 지정        
        - doc() 으로 문서의 ID 값 지정
- 문서 삭제 : delete() 함수
    - doc() 함수에서 삭제할 문서의 ID 지정
- 문서 조회 
    - 실시간(Stream) 업데이트
        - collection() 함수에 snapshots() 함수를 실행
        - 모든 문서를 Stream```<QuerySnapshot>``` 형태로 받아 올 수 있음
        - 컬렉션의 데이터가 업데이트 되면 즉시 화면 반영
    - 1회성(Future) 업데이트
        - get() 함수를 실행하면 Future```<QuerySnapshot>``` 반환
    - 특정 문서를 가져오고 싶으면 doc() 함수를 사용
- 문서 업데이트 : update() 함수

## 사전 준비
### pubspec, 네이티브 설정
- 파이어베이스 플러그인 추가
- minSdkVersion 21 설정

### 파이어베이스 CLI 설치 및 로그인
- window 용 CLI 바이너리 설치 및 로그인
- dart pub global activate flutterfire_cli
- 파이어스토어 콘솔에서 프로젝트 생성
- flutterfire configure -p ```<프로젝트ID>```
- 파이어스토어 데이터베이스 생성

## 구현하기
### 파이어베이스 설정 추가
- firebase_core 플러그인 Firebase.initializeApp() 함수로 설정 추가

### 일정 데이터 삽입
- ScheduleBottomSheet 위젯 onSavePressed() 함수 변경
- Firestore.instance.collection() 으로 특정 컬렉션 가져옴
- doc() 으로 저장하고 싶은 문서 ID 값 입력
- set() 함수로 저장

### 일정 데이터 조회하기
- home_screen 의 provider 제거
- StatefulWidget 으로 변경해서 상태관리
- List 위젯을 StreamBuilder 로 감싸서 보여줌
- QuerySnapshot 의 data.docs 값을 불러오면 쿼리에서 제공받은 모든 데이터를 리스트로 받아옴
    - QueryDocumentSnapshot 형태로 제공
    - data() 함수로 ```Map<String,dynamic>``` 형태로 데이터 전환

### 데이터 삭제
- 컬렉션 doc() 함수로 특정 문서 가져옴
- delete() 함수 실행

### main.dart 파일 정리
- provider 관련 제거