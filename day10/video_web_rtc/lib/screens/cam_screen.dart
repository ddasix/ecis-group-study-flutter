import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_web_rtc/constants/const.dart';

import '../components/components.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? rtcEngine;
  int? uid;
  int? otherUid;

  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    if (resp[Permission.camera] != PermissionStatus.granted ||
        resp[Permission.microphone] != PermissionStatus.granted) {
      throw '카메라 또는 마이크권한이 없습니다.';
    }

    if (rtcEngine == null) {
      rtcEngine = createAgoraRtcEngine();

      await rtcEngine!.initialize(
        RtcEngineContext(
          appId: APP_ID,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      rtcEngine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            print('채널에 입장함: ${connection.localUid}');
            setState(() {
              this.uid = connection.localUid;
            });
          },
          onLeaveChannel: (connection, stats) {
            print('채널퇴장');
            setState(() {
              this.uid = null;
            });
          },
          onUserJoined: (connection, remoteUid, elapsed) {
            print('상대가 입장: ${remoteUid}');
            setState(() {
              this.otherUid = remoteUid;
            });
          },
          onUserOffline: (connection, remoteUid, reason) {
            print('상대가 퇴장');

            setState(() {
              otherUid = null;
            });
          },
        ),
      );

      await rtcEngine!
          .setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await rtcEngine!.enableVideo();
      await rtcEngine!.startPreview();
      await rtcEngine!.joinChannel(
        token: TEMP_TOKEN,
        channelId: CHANNEL_NAME,
        uid: 0,
        options: ChannelMediaOptions(),
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(uid, rtcEngine),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(otherUid, rtcEngine),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (rtcEngine != null) {
                      await rtcEngine!.leaveChannel();
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('채널나가기'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
