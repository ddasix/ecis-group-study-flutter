import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Widget renderSubView(otherUid, rtcEngine) {
  if (otherUid != null) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: rtcEngine,
        canvas: VideoCanvas(uid: otherUid),
        connection: RtcConnection(channelId: dotenv.env['CHANNEL_NAME']),
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
