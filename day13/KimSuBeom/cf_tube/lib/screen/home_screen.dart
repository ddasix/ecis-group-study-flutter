import 'package:flutter/material.dart';
import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '코팩튜브',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: YoutubeRepository.getVideos(), //유투브 영상 가져오기
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (!snapshot.hasData) {
            //로딩 중
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            //새로 고침
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              physics: //스크롤 동작의 물리적 특성을 정의
                  const BouncingScrollPhysics(), // 아래로 당겨서 스크롤 할때 튕기는 에니메이션
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
