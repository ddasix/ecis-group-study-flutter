import 'package:flutter/material.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final VideoModel videoModel; //상위 위젯에서 입력받을 동영상 정보
  const CustomYoutubePlayer({super.key, required this.videoModel});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      initialVideoId: widget.videoModel.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false, //자동 실행 금지
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true, //동영상 진행상황을 알려주는 슬라이더
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.videoModel.title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    controller!.dispose();
  }
}
