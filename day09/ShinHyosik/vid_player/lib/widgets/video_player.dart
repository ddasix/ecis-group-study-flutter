import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/widgets/icon_button.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    super.key,
    required this.video,
    required this.onNewVideoPressed,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  bool showControlPanel = false;

  @override
  void initState() {
    super.initState();

    initialVideoController();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initialVideoController();
    }
  }

  @override
  void dispose() {
    videoPlayerController!.removeListener(videoPlayerControllerListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showControlPanel = !showControlPanel;
        });
      },
      child: AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController!),
            if (showControlPanel)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    renderTimeTextFromDuration(
                      videoPlayerController!.value.position,
                    ),
                    Expanded(
                      child: Slider(
                        onChanged: (value) {
                          videoPlayerController!
                              .seekTo(Duration(seconds: value.toInt()));
                        },
                        value: videoPlayerController!.value.position.inSeconds
                            .toDouble(),
                        min: 0,
                        max: videoPlayerController!.value.duration.inSeconds
                            .toDouble(),
                      ),
                    ),
                    renderTimeTextFromDuration(
                        videoPlayerController!.value.duration),
                  ],
                ),
              ),
            ),
            if (showControlPanel)
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: widget.onNewVideoPressed,
                  icon: Icons.photo_camera_back,
                ),
              ),
            if (showControlPanel)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      onPressed: onReversePressed,
                      icon: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      onPressed: onPlayPressed,
                      icon: videoPlayerController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      icon: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void initialVideoController() {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path))
      ..initialize().then(
        (value) {
          setState(() {});
        },
      );

    videoPlayerController!.addListener(videoPlayerControllerListener);
  }

  void onReversePressed() {
    final currentPosition = videoPlayerController!.value.position;

    var position = const Duration(); // default 0초로 초기화

    if (currentPosition.inSeconds > 3) {
      // 남은 시간이 3초 이상일때
      position = currentPosition - const Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  void onPlayPressed() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }

  void onForwardPressed() {
    final currentPosition = videoPlayerController!.value.position;
    final maxPosition = videoPlayerController!.value.duration;

    var position = maxPosition;

    if ((maxPosition - const Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      // 남은 시간이 3초보다 많이 남았을 때
      position = currentPosition + const Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  void videoPlayerControllerListener() {
    setState(() {});
  }

  Widget renderTimeTextFromDuration(Duration position) {
    return Text(
      '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
      style: const TextStyle(color: Colors.white),
    );
  }
}
