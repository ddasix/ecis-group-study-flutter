import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/components/app_bar.dart';
import 'package:image_editor/components/emo_sticker.dart';
import 'package:image_editor/components/footer.dart';
import 'package:image_editor/models/sticker_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  Set<StickerModel> stickers = {};
  String? selectedId;
  final imgKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          renderAppBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onDeleteItem: onDeleteItem,
              onSaveImage: () => onSaveImage(context),
            ),
          ),
          if (image != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppFooter(
                onEmoticonTap: onEmoticonTap,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      stickers = {};
      this.image = image;
    });
  }

  void onDeleteItem() async {
    // final emo1 =
    //     StickerModel(id: 'emo1', imagePath: 'assets/images/emoticon_1.png');
    // final emo2 =
    //     StickerModel(id: 'emo2', imagePath: 'assets/images/emoticon_2.png');

    // print((emo1 + emo2).id);
    // print((emo1 + emo2).imagePath);

    setState(() {
      // stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();

      stickers = stickers.map((StickerModel sticker) {
        if (sticker.id == selectedId) {
          sticker.isHidden = true;
        }
        return sticker;
      }).toSet();
    });
  }

  Future<void> onSaveImage(context) async {
    final boundary =
        imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    print(boundary);
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    await ImageGallerySaver.saveImage(pngBytes, quality: 100);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('저장되었습니다.'),
      ),
    );
  }

  Widget renderAppBody() {
    if (image == null) {
      return Center(
        child: TextButton(
          onPressed: onPickImage,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text('Select Image'),
        ),
      );
    }
    return Positioned.fill(
      child: RepaintBoundary(
        key: imgKey,
        child: InteractiveViewer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                File(image!.path),
                fit: BoxFit.cover,
              ),
              ...stickers.map(
                (StickerModel sticker) => Center(
                  child: EmoSticker(
                    key: ObjectKey(sticker.id),
                    onTransform: () => onTransform(sticker.id),
                    imagePath: sticker.imagePath,
                    isSelected: selectedId == sticker.id,
                    isHidden: sticker.isHidden!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onEmoticonTap(int index) {
    print('onEmoticonTap: $index');

    setState(() {
      stickers.add(
        StickerModel(
          id: const Uuid().v4(),
          imagePath: 'assets/images/emoticon_$index.png',
        ),
      );
    });
  }

  void onTransform(String id) {
    setState(() {
      selectedId = id;
    });
  }
}
