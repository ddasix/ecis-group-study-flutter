import 'dart:convert';

import 'package:cf_tube/constants/api.dart';
import 'package:cf_tube/models/video_model.dart';
import 'package:cf_tube/models/youtube_video.dart';
import 'package:dio/dio.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    final Response resp = await Dio().get(
      YOUTUBE_API_BASE_URL,
      queryParameters: {
        'channelId': CF_CHANNEL_ID,
        'maxResults': 50,
        'key': API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    final youtubeVideo = YoutubeVideos.fromJson(resp.data);
    final listWithData = youtubeVideo.items.where(
      (Item item) => item.id.videoId != '' && item.snippet.title != '',
    );

    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
            id: item.id.videoId,
            title: item.snippet.title,
          ),
        )
        .toList();
  }
}
