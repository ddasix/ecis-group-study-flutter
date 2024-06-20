import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final VoidCallback onPickImage;  // 이미지 선택 버튼 눌렀을 때 실행할 함수
  final VoidCallback onSaveImage;  // 이미지 저장 버튼 눌렀을 때 실행할 함수
  final VoidCallback onDeleteItem;  // 이미지 삭제 버튼 눌렀을 때 실행할 함수

  const MainAppBar({
    required this.onPickImage,
    required this.onSaveImage,
    required this.onDeleteItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, //p160 간격 균등, 왼쪽 오른쪽 끝을 위젯 사이 거리의 반만큼
        crossAxisAlignment: CrossAxisAlignment.end, //p161 끝에 정렬
        children: [
          IconButton(  // 이미지 선택 버튼
            onPressed: onPickImage,
            icon: Icon(
              Icons.image_search_outlined,
              color: Colors.grey[700],
            ),
          ),
          IconButton(  // 스티커 삭제 버튼
            onPressed: onDeleteItem,
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.grey[700],
            ),
          ),
          IconButton(  // 이미지 저장 버튼
            onPressed: onSaveImage,
            icon: Icon(
              Icons.save,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}