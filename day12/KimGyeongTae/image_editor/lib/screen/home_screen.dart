import 'package:flutter/material.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor/component/footer.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_editor/component/emoticon_sticker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image; // 선택한 이미지를 저장할 변수
  Set<StickerModel> stickers = {};  // 화면에 추가된 스티커들을 저장할 변수
  String? selectedId;  // 현재 선택된 스티커의 ID
  GlobalKey imgKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(  // Body, AppBar, Footer 순서로 쌓는다
        fit: StackFit.expand, // 자식 위젯이 차지할 수 있는 최대 크기로 배치
        children: [
          renderBody(),
          Positioned(
            top: 0, // MainAppBar 를 좌, 우, 위 끝에 정렬
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          if (image != null)  // image가 선택되면 Footer 위치하기
            Positioned(  // 맨 아래에 Footer 위젯 위치하기
              bottom: 0,
              left: 0,  // left와 right를 모두 0을 주면 좌우로 최대 크기를 차지함
              right: 0,
              child: Footer(
                onEmoticonTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (image != null) {
      return RepaintBoundary(
        key: imgKey,  // 위젯을 이미지로 저장하기 위해 사용
        child: Positioned.fill(   // Stack 크기의 최대 크기만큼 차지
          child: InteractiveViewer(   // 확대, 좌우 이동 가능하게 하는 위젯
            child: Stack(
              fit: StackFit.expand, // 최대 크기로 늘려준다
              children: [
                Image.file(
                  File(image!.path),
                  fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지 하도록
                ),
                ...stickers.map(
                      (sticker) => Center( // 최초 스티커 선택 시 중앙에 배치
                    child: EmoticonSticker(
                      key: ObjectKey(sticker.id),
                      onTransform: () {
                        onTransform(sticker.id); // 스티커의 ID 값 함수의 매개변수로 전달
                      },
                      imgPath: sticker.imgPath,
                      isSelected: selectedId == sticker.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // 이미지 선택이 안 된 경우 이미지 선택 버튼 표시
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: const Text('이미지 선택하기'),
        ),
      );
    }
  }

  void onEmoticonTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: const Uuid().v4(), // 스티커의 고유 ID
          imgPath: 'asset/img/emoticon_$index.png',
        ),
      };
    });
  }

  void onPickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택하기

    setState(() {
      this.image = image; // 선택한 이미지 변수에 저장하기
    });
  }

  void onSaveImage() async {
    RenderRepaintBoundary boundary = imgKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(); // 바운더리를 이미지로 변경
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png); // byte data 형태로 형태 변경
    Uint8List pngBytes = byteData!.buffer.asUint8List(); // Unit8List 형태로 형태 변경

    await ImageGallerySaver.saveImage(pngBytes, quality: 100);  // 이미지 저장하기

    ScaffoldMessenger.of(context).showSnackBar(  // 저장 후 Snackbar 보여주기
      const SnackBar(
        content: Text('저장되었습니다!'),
      ),
    );
  }

  void onDeleteItem() async {
    setState(() {
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();  // 현재 선택돼 있는 스티커 삭제 후 Set로 변환
    });
  }

  void onTransform(String id){  // 스티커가 변형될 때마다 변형 중인 스티커를 현재 선택한 스티커로 지정
    setState(() {
      selectedId = id;
    });
  }
}