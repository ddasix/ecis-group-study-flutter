import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'dart:io';

// 동영상 위젯
class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 동영상 저장 변수

  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer(
      {super.key, required this.video, required this.onNewVideoPressed});

  @override
  State<StatefulWidget> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController; //동영상 조작 컨트롤러, initState() 함수에서 설정

  bool showControls = false; //동영상 조작하는 아이콘 표시 여부

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void initState() {
    super.initState();
    initializeController(); // 컨트롤러 초기화
  }

  initializeController() async {
    // 선택한 동영상으로 컨트롤러 초기화
    final videoController = VideoPlayerController.file(
      //파일로부터 컨트롤러 생성
      File(widget.video.path),
    );

    await videoController.initialize(); // 동영상 재생 준비

    //컨트롤러의 속성이 변경될 때마다 실행할 함수 등록
    videoController.addListener(videoControllerListerner);

    setState(() {
      this.videoController = videoController;
      // 준비가 완료되면 this.controller 에 준비된 컨트롤러 변수를 저장
    });
  }

  //동영상 재생 상태가 변경될 때마다 setState() 실행해서 build 재실행
  void videoControllerListerner() {
    setState(() {});
  }

//State 폐기될 때 같이 폐기
  @override
  void dispose() {
    // 리스너 삭제
    videoController?.removeListener(videoControllerListerner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 초기화가 성공하지 못하면 컨트롤러가 널이므로 로딩 중 표시
    if (videoController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      // 화면 전체의 탭을 인식
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio, // 입력된 동영상의 비율을 넣어 줌
        child: Stack(
          children: [
            VideoPlayer(
              videoController!,
            ),
            if (showControls) // 조작 버튼이 보일땐 화면을 어둡게 변경
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            Positioned(
              //Stack 위치 지정
              bottom: 0, // Stack 위치 가장 아래에 위젯 위치
              right: 0,
              left: 0, //left와 right 모두 0을 줌으로 슬라이더를 가로 전체로 늘림
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8), //가로 8 여백 추가
                child: Row(
                  children: [
                    //동영상 현재 위치 표시
                    renderTimeTextFromDuration(videoController!.value.position),
                    Expanded(
                      child: Slider(
                        // 동영상 조정 슬라이더
                        onChanged: (double val) {
                          // 슬라이더가 이동할때 동영상 위치를 이동
                          videoController!.seekTo(
                            Duration(seconds: val.toInt()),
                          );
                        },
                        value: videoController!.value.position.inSeconds
                            .toDouble(),
                        // 동영상 재생 위치를 초단위로 표현
                        min: 0,
                        max: videoController!.value.duration.inSeconds
                            .toDouble(),
                        // 선택된 동영상 재생길이를 초단위로
                      ),
                    ),
                    //동영상 총 길이 표시
                    renderTimeTextFromDuration(
                      videoController!.value.duration,
                    )
                  ],
                ),
              ),
            ),
            if (showControls)
              Align(
                // 우상단 새 동영상 아이콘 위치
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  iconData: Icons.photo_camera_back,
                  onPressed: widget.onNewVideoPressed,
                ),
              ),
            if (showControls)
              Align(
                //동영상 재생 관련 아이콘 중앙 위치
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      //되감기 버튼
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      // 재생, 정지 버튼
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

  //되감기 함수
  void onReversePressed() {
    final currentPosition = videoController!.value.position;
    Duration position = const Duration(); //0초로 실행 위치 초기화

    if (currentPosition.inSeconds > 3) {
      //현 위치가 3초 이후일때 3초 빼기 아니면 초기화인 0의 위치
      position = currentPosition - const Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  // 앞으로 감기 함수
  void onForwardPressed() {
    final currentPosition = videoController!.value.position;
    final maxPosition = videoController!.value.duration;
    Duration position = maxPosition; //동영상 길이로 실행 위치 초기화

    if ((maxPosition - const Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + const Duration(seconds: 3);
      //동영상 길이에서 3초 뺀 값보다 현재 위치가 짧을 때만 3초 더하기 아니면 초기 동영상 긑 위치
    }
    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      "${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
