import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; //동영상을 저장할 변수 - image_picker 플러그인 반환 값
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // 동영상이 선택 되었을 때와 아닐 때 위젯 선택
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

//동영상 선택이 없을 때 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, //현재 화면의 너비(최대 너비)
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed, //로고 위젯을 탭했을 때 실행
          ),
          const SizedBox(height: 30),
          _AppName(),
        ],
      ),
    );
  }

//pickVideo 로 동영상 선택 화면 실행
// 소스 매개변수로 갤러리 또는 카메라 선택
// 선택한 동영상을 XFile 형태로 비동기로 반환
  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

// 동영상이 선택되었을 때 위젯
  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!, // 선택한 동영상을 전달
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }
}

BoxDecoration getBoxDecoration() {
  return const BoxDecoration(
    //그라데이션 색상 적용
    gradient: LinearGradient(
      // 선형 색상 적용
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF2A3A7C),
        Color(0xFF000118),
      ],
    ),
  );
}

//로고 화면 위젯
class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const _Logo({required this.onTap}); // 로고 위젯 탭 했을때 실행할 함수

//Image.asset 을 GestureDetector 로 감싸서 onTap 함수를 외부에서 입력받음
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('asset/img/logo.png'),
    );
  }
}

//앱 제목 위젯
class _AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
