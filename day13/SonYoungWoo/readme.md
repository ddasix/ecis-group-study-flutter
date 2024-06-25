# Chapter 16. 코팩튜브
## 사전지식
### HTTP 요청
- 웹상에서 데이터를 요청하고 응답하는 프로토콜로 http(80),https(443) 이용.
- protocol,host,port,path,query 구조의 url를 가지고 있음.
- GET 메서드 : 서버로 부터 데이터를 가져옴.
- POST 메서드 : 데이터를 서버에 저장.
- PUT 메서드 : 데이터를 업데이트.
- DELETE 메서드 : 데이터를 삭제.
### REST API
- REST 기준을 따르는 HTTP API
- 균일한 인터페이스, 무상태, 계층화된 시스템, 캐시의 기준.
### JSON
- HTTP 요청에서 body를 구성하는 구조
- json 형태의 구조로 된 데이터를 직렬화하여 클래스의 인스턴스로 사용.

### 사전준비
- 구글 클라우드 콘솔에서 Youtube data api v3 활성화.
 
### pubspec.yaml 설정
- youtue_player_flutter 설정
- dio 설정


## home_screen 구현
```dart
import 'package:flutter/material.dart';
import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:cf_tube/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
 }

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text("코팩튜브"),
          backgroundColor: Colors.black,
        ),

        body: FutureBuilder<List<VideoModel>>(
          future: YoutubeRepository.getVideos(),
          builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {

            if(snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data!
                    .map((e) => CustomYoutubePlayer(videoModel: e))
                    .toList(),
              ),
            );
          },

        )
    );
  }

}
```
## video_model 구현
```dart
class VideoModel {
  final String id;
  final String title;

  VideoModel({
    required this.id,
    required this.title,
  });

}
```

## youtube_repository 구현
```dart
import 'package:cf_tube/const/api.dart';
import 'package:dio/dio.dart';
import 'package:cf_tube/model/video_model.dart';


class YoutubeRepository {

  static Future<List<VideoModel>> getVideos() async {
    final resp = await Dio().get(
      YOUTUBE_API_BASE_URL,
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      }
    );

    final listWithData = resp.data['items'].where(
          (item) =>
      item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
        id: item['id']['videoId'],
        title: item['snippet']['title'],
      ),
    ).toList();

  }

}
```

## custom_youtube_player 구현
```dart
import 'package:flutter/material.dart';
import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:cf_tube/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
 }

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text("코팩튜브"),
          backgroundColor: Colors.black,
        ),

        body: FutureBuilder<List<VideoModel>>(
          future: YoutubeRepository.getVideos(),
          builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {

            if(snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data!
                    .map((e) => CustomYoutubePlayer(videoModel: e))
                    .toList(),
              ),
            );
          },

        )
    );
  }

}
```
