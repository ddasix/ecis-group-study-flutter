// ignore_for_file: public_member_api_docs, sort_constructors_first
class YoutubeVideos {
  final String kind;
  final String etag;
  final String nextPageToken;
  final String regionCode;
  final List<Item> items;
  final PageInfo pageInfo;

  YoutubeVideos({
    required this.kind,
    required this.etag,
    required this.nextPageToken,
    required this.regionCode,
    required this.items,
    required this.pageInfo,
  });

  factory YoutubeVideos.fromJson(dynamic json) {
    var list = json['items'] as List;
    print('YoutubeVideos.fromJson');

    return YoutubeVideos(
      kind: json['kind'] == null ? '' : json['kind'] as String,
      etag: json['etag'] == null ? '' : json['etag'] as String,
      regionCode:
          json['regionCode'] == null ? '' : json['regionCode'] as String,
      nextPageToken:
          json['nextPageToken'] == null ? '' : json['nextPageToken'] as String,
      items: list.isNotEmpty ? list.map((i) => Item.fromJson(i)).toList() : [],
      pageInfo: PageInfo.fromJson(json['pageInfo']),
    );
  }
}

class PageInfo {
  final int totalResults;
  final int resultsPerPage;

  PageInfo({required this.totalResults, required this.resultsPerPage});

  factory PageInfo.fromJson(dynamic json) {
    print('PageInfo.fromJson');
    return PageInfo(
      totalResults:
          json['totalResults'] == null ? 0 : json['totalResults'] as int,
      resultsPerPage:
          json['resultsPerPage'] == null ? 0 : json['resultsPerPage'] as int,
    );
  }
}

class Item {
  final String kind;
  final String etag;
  final ItemId id;
  final Snippet snippet;

  Item({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
  });

  factory Item.fromJson(dynamic json) {
    print('Item.fromJson');
    return Item(
      kind: (json['kind'] ?? '') as String,
      etag: (json['etag'] ?? '') as String,
      id: ItemId.fromJson(json['id']),
      snippet: Snippet.fromJson(json['snippet']),
    );
  }
}

class ItemId {
  final String kind;
  final String videoId;

  ItemId({
    required this.kind,
    required this.videoId,
  });

  factory ItemId.fromJson(dynamic json) {
    
    print('ItemId.fromJson');
    return ItemId(
      kind: (json['kind'] ?? '') as String,
      videoId: (json['videoId'] ?? '') as String,
    );
  }
}

class Snippet {
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnail thumbnails;
  final String channelTitle;
  final String playlistId;
  final int position;
  final ResourceId? resourceId;
  final String videoOwnerChannelTitle;
  final String videoOwnerChannelId;

  Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
    required this.playlistId,
    required this.position,
    required this.resourceId,
    required this.videoOwnerChannelTitle,
    required this.videoOwnerChannelId,
  });

  factory Snippet.fromJson(dynamic json) {
    print('Snippet.fromJson');
    return Snippet(
      publishedAt:
          json['publishedAt'] == null ? '' : json['publishedAt'] as String,
      channelId: json['channelId'] == null ? '' : json['channelId'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      thumbnails: Thumbnail.fromJson(json['thumbnails']),
      channelTitle:
          json['channelTitle'] == null ? '' : json['channelTitle'] as String,
      playlistId:
          json['playlistId'] == null ? '' : json['playlistId'] as String,
      position: json['position'] == null ? 0 : json['position'] as int,
      resourceId: json['resourceId'] != null ? ResourceId.fromJson(json['resourceId']): null,
      videoOwnerChannelTitle: json['videoOwnerChannelTitle'] == null
          ? ''
          : json['videoOwnerChannelTitle'] as String,
      videoOwnerChannelId: json['videoOwnerChannelId'] == null
          ? ''
          : json['videoOwnerChannelId'] as String,
    );
  }
}

class Thumbnail {
  final ThumbnailInfo default_;
  final ThumbnailInfo medium;
  final ThumbnailInfo high;

  Thumbnail({
    required this.default_,
    required this.medium,
    required this.high,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        default_: ThumbnailInfo.fromJson(json['default']),
        medium: ThumbnailInfo.fromJson(json['medium']),
        high: ThumbnailInfo.fromJson(json['high']),
      );
}

class ThumbnailInfo {
  final String url;
  final int width;
  final int height;

  ThumbnailInfo({
    required this.url,
    required this.width,
    required this.height,
  });

  factory ThumbnailInfo.fromJson(Map<String, dynamic> json) => ThumbnailInfo(
        url: json['url'],
        width: json['width'],
        height: json['height'],
      );
}

class ResourceId {
  final String kind;
  final String videoId;

  ResourceId({
    required this.kind,
    required this.videoId,
  });

  factory ResourceId.fromJson(dynamic json) {
    print('ResourceId.fromJson');
    return ResourceId(
      kind: json['kind'] == null ? '' : json['kind'] as String,
      videoId: json['videoId'] == null ? '' : json['videoId'] as String,
    );
  }
}
