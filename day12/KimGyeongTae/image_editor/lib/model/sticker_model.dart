class StickerModel {
  final String id;
  final String imgPath;

  StickerModel({
    required this.id,
    required this.imgPath,
  });

  //https://pub.dev/ -> equatable
  @override
  bool operator ==(Object other) {  // ==로 같은지 비교할 때 사용되는 로직
    return (other as StickerModel).id == id; // ID값이 같은 인스턴스끼리는 같은 스티커로 인식
  }

  // Set 등 해시값을 사용하는 데이터 구조에서 사용하는 getter
  // ID값이 같으면 Set 안에서 같은 인스턴스로 인식
  @override
  int get hashCode => id.hashCode;
}