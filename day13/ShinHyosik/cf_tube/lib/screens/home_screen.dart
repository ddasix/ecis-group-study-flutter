import 'package:cf_tube/components/video_player.dart';
import 'package:cf_tube/models/video_model.dart';
import 'package:cf_tube/repositories/youtube_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('코팩튜브'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: snapshot.data!.map(
                (VideoModel videoModel) {
                  return VideoPlayer(videoModel: videoModel);
                },
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
