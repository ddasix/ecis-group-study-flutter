import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform; // 스티커의 상태가 변경될 때마다 실행
  final String imgPath; // 이미지 경로
  final bool isSelected; // 현재 어떤 스티커가 선택되어 있는지 아는 변수

  const EmoticonSticker({
    required this.onTransform,
    required this.imgPath,
    required this.isSelected,
    super.key,
  });

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker> {
  double scale = 1; // 확대,축소 배율
  double hTransform = 0;  // 가로의 움직임
  double vTransform = 0;  // 세로의 움직임
  double actualScale = 1; // 위젯의 초기 크기 기준 확대/축소 배율

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity() // 자식 위젯의 위치, 크기, 회전을 조정
        ..translate(hTransform, vTransform) // 상,하 움직임 정의
        ..scale(scale, scale), // 확대,축소 정의

      child: Container(
        decoration: widget.isSelected
            ? BoxDecoration(  // 스티커가 선택 됐을 때 테두리
          borderRadius: BorderRadius.circular(4.0), // 모서리 둥글게
          border: Border.all(
            color: Colors.blue,
            width: 1.0,
          ),
        )
            : BoxDecoration(  // 스티커 선택 안됐을 때 테두리
          border: Border.all(
            width: 1.0,  // 테두리 투명, 너비 1로 해서 선택 취소될 때 깜빡임 현상 제거
            color: Colors.transparent,
          ),
        ),

        child: GestureDetector(
          onTap: () { // 스티커를 눌렀을 때 실행할 함수
            widget.onTransform(); // 스티커의 상태가 변경될 때마다 실행
          },
          // 스티커의 확대 비율이 변경됐을 때 실행
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              scale = details.scale * actualScale; // 변화한 확대 비율 * 최신 확대 비율 (최근 확대 비율 기반으로 실제 확대 비율 계산)
              vTransform += details.focalPointDelta.dy; // 세로 y축 이동 거리 계산
              hTransform += details.focalPointDelta.dx; // 가로 x축 이동 거리 계산
            });
          },
          // 스티커의 확대 비율 변경이 완료됐을 때 실행
          onScaleEnd: (ScaleEndDetails details) {
            actualScale = scale; // 확대 비율 저장해둬야 한다
          },
          child: Image.asset(
            widget.imgPath, // 보여줄 스티커의 경로를 저장
          ),
        ),
      ),
    );
  }
}