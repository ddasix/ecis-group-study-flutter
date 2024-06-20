import 'package:flutter/material.dart';

typedef OnEmoticonTap = void Function(int id);  // 스티커를 선택할 때마다 실행할 함수의 시그니처
class Footer extends StatelessWidget {
  final OnEmoticonTap onEmoticonTap;

  const Footer({
    required this.onEmoticonTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      height: 150,
      child: SingleChildScrollView(  // 가로로 스크롤 가능하게 스티커 구현
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            7,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // p156 수평 방향으로 8픽셀의 간격을 설정
              child: GestureDetector(  // p150 사용자의 터치, 드래그등의 제스처를 감지하는 위젯
                onTap: () {
                  onEmoticonTap(index + 1);  // 스티커 선택할 때 실행할 함수
                },
                child: Image.asset(
                  'asset/img/emoticon_${index + 1}.png',
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}