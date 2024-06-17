# 영상통화

## 사전지식
### 카메라 플러그 인
- camera: 0.11.0+1

### WebRTC
-  WebRTC API 를 통해 음성 통화, 영상 통화, P2P 파일 공유 가능
- 중계용 서버(시그널링 서버 Signalling Server) 필요
    - 아고라 서비스 이용
- WebRTC를 사용할 클라이언트들은 서로 연결할 수 있는 공개 IP 등 정보를 서버에 전송하고 상대 연결 정보 받아옴
- 서버에서 받아온 정보를 기반으로 내 영상 및 음성을 공유

### 내비게이션
- 화면을 이동할 때 사용하는 클래스
- 스택 이라는 데이터 구조로 설계
    - LIFO(Last In First Out) 구조

## 사전 준비
- 아고라 가입 및 토큰 획득
    - const 파일에 값 정리
- 이미지 및 폰트 추가
- 플러터 권한 관리
    - permission_handler 패키지로 관리

## 구현하기
### 홈스크린 위젯
- 로고, 이미지, 버튼 구현
- 로고 
    - 아이콘과 글자가 컨테이너 안에 위치
    - BoxDecoration 클래스의 boxShadow 매개 변수로 그림자 구현

### 캠스크린 위젯
- 내비게이션 : 화면전환
- Navigator 클래스 
    - 화면을 스택처럼 관리, 새로운 화면을 푸시(push)해 추가 하고 현재 하면을 팝(pop) 하여 제거
    - MaterialPageRoute로 화면 전환을 관리
- FutureBuilder : Future를 반환하는 함수의 결과에 따라 위젯을 랜더링 할 때 사용
    - future 매개변수 : Future 값을 반환하는 함수
    - builder 매개변수 : Future 값에 따라 다르게 랜더링 해주고 싶은 로직 작성
    - builder 함수는 BuildContext 와 AsyncSnapshot 제공
    - AsyncSnapshot 은 future 매개변수에 입력한 함수의 결괏값 및 에러를 제공
    - AsyncSnapshot 에서 제공하는 값이 변경될 때마다 builder 함수 재실행
    - 화면 깜박임 방지를 위해 snapshot.connectionState 대신 hasData 사용