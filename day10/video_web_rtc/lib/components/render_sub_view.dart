import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:video_web_rtc/constants/const.dart';

Widget renderSubView(otherUid, rtcEngine) {
  if (otherUid != null) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: rtcEngine,
        canvas: VideoCanvas(uid: otherUid),
        connection: RtcConnection(channelId: CHANNEL_NAME),
      ),
    );
  } else {
    return Center(
      child: Text(
        '다른 사용자가 입장중입니다.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
