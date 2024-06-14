# 앱을 만들며 유용한 기능 익히기
## 12. 동영상 플레이어
- 핸드폰에 저장해둔 동영상을 선택하고 실행하고 컨트롤하는 기능 구현
### 구상하기
- 첫 화면에서 동영상 플레이어 logo 와 아래 VideoPlayer 라는 텍스트를 만들고 logo 를 클릭하면 영상을 플레이 한다
- 영상 컨트롤러(뒤로, 정지/재생, 앞으로, 다른 영상 선택) 버튼을 영상 위에 표시한다
- 하나의 위젯으로 2개의 함수를 구현하여 각 화면에 표시
### 네이티브 권한 설정하기
- 갤러리에서 사용자가 선택한 동영상을 불러오려면 안드로이드와 iOS 모두 갤러리 권한을 추가해야 한다
- 안드로이드
  - manifest.xml 파일에 READ_EXTERNAL_STORAGE 권한 추가
- iOS
  - info.plist 파일에 NSPhotoLibraryUsageDescription 권한 추가
### 12.3 레이아웃 구상
- 첫번째 화면 : icon 과 앱이름이 나오는 화면을 renderEmpty() 함수로 나타낸다
- 두번째 화면 : 동영상 플레이 화면을 renderVideo() 함수로 나타낸다
### 12.4 구현하기
#### 12.4.1 첫화면 : renderEmpty() 함수 구현하기
- 선택된 동영상을 의미하는 XFile 형태의 video 변수를 선언
- homeScreen 이 비디오가 선택됐을때 renderEmpty() 함수를 실행
- Column 위젯에 로고와 앱 이름을 넣어준다
- 선택되지 않았을때는 renderVideo() 함수를 실행
#### 12.4.2 배경색 그라데이션 구현하기
- BoxDecoration 클래스를 사용하면 그라데이션으로 꾸밀 수 있다
#### 12.4.3 파일 선택 기능 구현하기
- logo 를 탭하면 비디오와 사진을 선택할 수 있는 기능
- _Logo 위젯에 GestureDetector 를 추가해서 onTap() 함수가 실행됐을때 동영상을 선택하는 함수 구현
#### 12.4.4 플레이어 화면 구현하기
- CustomVideoPlayer 위젯을 배치
#### 12.4.5 동영상 재생기 구현하기
- 동영상을 재생하는 위젯
- renderVideo() 함수는 custom_video_player.dart 파일로부터 CustomVideoPlayer 위젯을 받아와서 렌더링
- video_player 패키지에서 VideoPlayerController 와 VideoPlayer 위젯을 사용해서 선택한 동영상 재생
- AspectRatio 는 child 매개변수에 입력되는 위젯의 비율을 정할 수 있는 위젯
#### 12.4.6 Slider 위젯 동영상과 연동하기
- Slider 위젯을 영상에 연동
- VideoPlayer 위젯 위에 Slider 위젯이 위치하도록 Stack 위젯을 사용한다
- 동영상이 현재 재생되고 있는 위치를 가져올 수 있는 value.position
- 동영상의 재생 위치를 변경할 수 있는 seekTo() 함수를 사용한다
#### 12.4.7 동영상 컨트롤 버튼 구현하기
- 뒤로가기, 재생/멈춤, 앞으로 가기 버튼 구현
- 버튼은 CustomsIconButton 위젯 사용
- didUpdateWidget() 함수를 사용해서 새로운 동영상이 선택되었을 때 videoController 를 새로 생성
#### 12.4.8 컨트롤러 감추기 기능 만들기
- 화면을 탭하면 버튼 컨트롤을 숨기고 다시 탭하면 컨트롤이 올라오게 한다 
#### 12.4.9 타임스탬프 추가하기
- 동영상이 현재 실행 중인 위치와 동영상 길이를 Slider 의 좌우에 배치

