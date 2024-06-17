import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

Widget renderMainView(uid, rtcEngine) {
  if (uid != null) {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  } else {
    return const CircularProgressIndicator();
  }
}
