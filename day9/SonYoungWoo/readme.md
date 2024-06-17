# Chapter 12. 동영상 플레이어
## 사전지식
### 시간변환
- Duration 클래스로 원하는 시간 화면으로 변환.

### pubspec.yaml 설정
- image_picker: 1.0.4 설정  
- video_player: 2.8.1 설정
- 각 플랫폼 갤러리 권한 추가

 
## home_screen 구현
```dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ➋ 동영상이 선택됐을 때와 선택 안 됐을때 보여줄 위젯
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty(){  // ➌ 동영상 선택 전 보여줄 위젯
    return Container(
      width: MediaQuery.of(context).size.width, // 넓이 최대로 늘려주기
      decoration: getBoxDecoration(),
      child: Column(

        // 위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),  // 로고 이미지
          SizedBox(height: 30.0),
          _AppName(),  // 앱 이름
        ],
      ),
    );
  }

  void onNewVideoPressed() async {  // ➋ 이미지 선택하는 기능을 구현한 함수
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(  // ➋ 그라데이션으로 색상 적용하기
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }

  Widget renderVideo(){
    return Center(
      child: CustomVideoPlayer(
        video: video!, // ➋ 선택된 동영상 입력해주기
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }
}

class _Logo extends StatelessWidget { // 로고를 보여줄 위젯
  final GestureTapCallback onTap;

  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // ➌ 상위 위젯으로부터 탭 콜백받기
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget { // 앱 제목을 보여줄 위젯
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,  // 글자 가운데 정렬
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(

            // ➊ textStyle에서 두께만 700으로 변경
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}


```

## custom_icon_button 구현
```dart
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;  // ➊ 아이콘을 눌렀을 때 실행할 함수
  final IconData iconData;  // ➋ 아이콘

  const CustomIconButton({
    required this.onPressed,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(  // 아이콘을 버튼으로 만들어주는 위젯
      onPressed: onPressed,  // 아이콘을 눌렀을 때 실행할 함수
      iconSize: 30.0,   // 아이콘 크기
      color: Colors.white,   // 아이콘 색상
      icon: Icon(       // 아이콘
        iconData,
      ),
    );
  }
}

```

## custom_video_player 구현
```dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:vid_player/component/custom_icon_button.dart';

// ➊ 동영상 위젯 생성
class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video, // 상위에서 선택한 동영상 주입해주기
    required this.onNewVideoPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  bool showControls = false;

  @override
  // covariant 키워드는 CustomVideoPlayer 클래스의 상속된 값도 허가해줍니다.
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ➊ 새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void initState() {
    super.initState();

    initializeController(); // ➋ 컨트롤러 초기화
  }

  initializeController() async {
    // ➌ 선택한 동영상으로 컨트롤러 초기화
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController.initialize();

    videoController.addListener(videoControllerListener);

    setState(() {
      this.videoController = videoController;
    });
  }

  void videoControllerListener() {
    setState(() {});
  }

  @override
  void dispose() {
    // ➋ listener 삭제
    videoController?.removeListener(videoControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      // ➋ 화면 전체의 탭을 인식하기 위해 사용
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          // ➊ children 위젯을 위로 쌓을 수 있는 위젯
          children: [
            VideoPlayer(
              // VideoPlayer 위젯을 Stack으로 이동
              videoController!,
            ),
            if(showControls)
              Container(  // ➌ 아이콘 버튼을 보일 때 화면을 어둡게 변경
                color: Colors.black.withOpacity(0.5),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    renderTimeTextFromDuration(
                      // 동영상 현재 위치
                      videoController!.value.position,
                    ),
                    Expanded(
                      // Slider가 남는 공간을 모두 차지하도록 구현
                      child: Slider(
                        onChanged: (double val) {
                          videoController!.seekTo(
                            Duration(seconds: val.toInt()),
                          );
                        },
                        value: videoController!.value.position.inSeconds
                            .toDouble(),
                        min: 0,
                        max: videoController!.value.duration.inSeconds
                            .toDouble(),
                      ),
                    ),
                    renderTimeTextFromDuration(
                      // 동영상 총 길이
                      videoController!.value.duration,
                    ),
                  ],
                ),
              ),
            ),
            if(showControls)
            Align(
              // ➊ 오른쪽 위에 새 동영상 아이콘 위치
              alignment: Alignment.topRight,
              child: CustomIconButton(
                onPressed: widget.onNewVideoPressed,
                iconData: Icons.photo_camera_back,
              ),
            ),
            if (showControls)
            Align(
              // ➋ 동영상 재생관련 아이콘 중앙에 위치
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    // 되감기 버튼
                    onPressed: onReversePressed,
                    iconData: Icons.rotate_left,
                  ),
                  CustomIconButton(
                    // 재생 버튼
                    onPressed: onPlayPressed,
                    iconData: videoController!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  CustomIconButton(
                    // 앞으로 감기 버튼
                    onPressed: onForwardPressed,
                    iconData: Icons.rotate_right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  void onReversePressed() {
    // ➊ 되감기 버튼 눌렀을 때 실행할 함수
    final currentPosition = videoController!.value.position; // 현재 실행 중인 위치

    Duration position = Duration(); // 0초로 실행 위치 초기화

    if (currentPosition.inSeconds > 3) {
      // 현재 실행위치가 3초보다 길때만 3초 빼기
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onForwardPressed() {
    // ➋ 앞으로 감기 버튼 눌렀을 때 실행할 함수
    final maxPosition = videoController!.value.duration; // 동영상 길이
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    // 동영상 길이에서 3초를 뺀 값보다 현재 위치가 짧을 때만 3초 더하기
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    // ➌ 재생 버튼을 눌렀을 때 실행할 함수
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }
}

```
