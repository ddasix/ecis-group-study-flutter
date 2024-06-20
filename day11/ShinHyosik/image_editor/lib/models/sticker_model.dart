// ignore_for_file: public_member_api_docs, sort_constructors_first
class StickerModel {
  final String id;
  final String imagePath;
  bool? isHidden;

  StickerModel({
    required this.id,
    required this.imagePath,
    this.isHidden = false,
  });

  @override
  bool operator ==(Object other) {
    return (other as StickerModel).id == id;
  }

  StickerModel operator +(StickerModel other) {
    return StickerModel(id: '$id + ${other.id}', imagePath: '$imagePath + ${other.imagePath}');
  }
  
  @override
  int get hashCode => id.hashCode;
}
