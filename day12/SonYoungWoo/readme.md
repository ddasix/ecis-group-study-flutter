# Chapter 15. 포토 스티커
## 사전지식
### GestureDetector
1. onDoubleTap : 빠르게 두번 탭할시 작동한다. 
2. onForcePress : 압력을 감지한다. 롱프레스가 더 범용적이라 나는 롱프레스를 사용한다.
3. onHorizontalDrag : X좌표 좌우 드래그만 감지한다. Update되는 drag 값을 기반으로, 끝날 때 작동이 벌어지게 설정하면 된다. 
4. onLongPress : 길게 누르면 작동한다.
5. onPan : X/Y좌표 드래그를 모두 감지한다. 보통 이미지 같은 것들을 자유롭게 이동시키거나 할 때 사용한다.
6. onScale : 손가락 두개로 확대 축소를 한다. 특정 상황에서는 확대된 위젯 크기에 따라 render Overflow가 있을 수 있다.
7. onSecondaryLongPress[웹] : 더블탭 롱프레스 같은 걸로 생각해으나, 그게 아니라 웹에서 우클릭 롱프레스 정도로 생각하면 된다.
8. onTap : 탭할시 작동한다. 가장 일반적인 사용이다.
9. onTertiaryLongPress[웹] : 7번과 동일하다.
10. onTertiaryTap[웹] : 웹에서 우클릭 정도로 생각하면 된다.
11. onVerticalDrag : Y좌표 상하 드래그만 감지한다. Update되는 drag 값을 기반으로, 끝날 때 작동이 벌어지게 설정하면 된다.
### 사전준비
- 이미지 파일 에뮬레이터로 복사
 
### pubspec.yaml 설정
- image_picker 설정
- image_gallery_saver 설정
- uuid 설정
  
## home_screen 구현
```dart
import "package:flutter/material.dart";
import "package:image_editor/component/main_app_bar.dart";
import 'package:image_picker/image_picker.dart';
import 'package:image_editor/component/footer.dart';
import 'dart:io';
import 'package:image_editor/component/emoticon_sticker.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  XFile? image;
  Set<StickerModel> stickers = {};
  String? selectedId;
  GlobalKey imgKey = GlobalKey();

  void onPickImage () async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
    });
  }

  void onSaveImage(){
    RenderRepaintBoundary boundary = imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  }

  void onDeleteImage() async{
    setState(() {
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            renderBody(),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child:
                MainAppBar(onPickImage: onPickImage, onSaveImage: onSaveImage, onDeleteImage: onDeleteImage)
            ),
            if(image !=null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Footer(
                  onEmoticonTap: onEmoticonTap,
                ),
              )
          ],
        )
    );
  }

  Widget renderBody(){
    if(image != null){
      return RepaintBoundary(

        key: imgKey,
        child: Positioned.fill(
          child: InteractiveViewer(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(image!.path),
                  fit: BoxFit.cover,
                ),
                ...stickers.map(
                      (sticker) => Center(
                    child: EmoticonSticker(
                      key: ObjectKey(sticker.id),
                      onTransform: () {
                        onTransform(sticker.id);
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
      return Center(
        child: TextButton(
          child: Text("이미지 선택하기"),
          onPressed: onPickImage,
        ),
      );
    }

  }

  void onTransform(String id){
    setState(() {
      selectedId = id;
    });
  }

  void onEmoticonTap (int index) async{

    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(),
          imgPath: "asset/img/emoticon_$index.png"
        )
      };
    });

  }

}

```
## emoticon_sticker 구현
```dart
import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget{
  final VoidCallback onTransform;
  final String imgPath;
  final bool isSelected;

  const EmoticonSticker({super.key, required this.onTransform, required this.imgPath, required this.isSelected});

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker>{

  double scale = 1;
  double hTransform = 0;
  double vTransform = 0;
  double actualScale =1;


  @override
  Widget build(BuildContext context) {

    return Transform(
        transform: Matrix4.identity()..translate(hTransform,vTransform)..scale(scale,scale),

    child: Container(
      decoration: widget.isSelected?
      BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Colors.blue,
          width: 1.0,
        ),
      ) : BoxDecoration(
        border: Border.all(
          width: 1.0,
          color:  Colors.transparent,
        ),
      ),
      child:GestureDetector(
        onTap: () {
          widget.onTransform();
        },
        onScaleUpdate: (ScaleUpdateDetails details){
          widget.onTransform();
          setState(() {
            scale = details.scale * actualScale;
            vTransform += details.focalPointDelta.dy;
            hTransform += details.focalPointDelta.dx;
          });

        },
        onScaleEnd: (ScaleEndDetails details){
          actualScale = scale;
        },
        child: Image.asset(widget.imgPath),
      ),
    ),
    );

  }

}
```

## main_app_bar 구현
```dart
import "package:flutter/material.dart";

class MainAppBar extends StatelessWidget{
  final VoidCallback onPickImage;
  final VoidCallback onSaveImage;
  final VoidCallback onDeleteImage;

  const MainAppBar({required this.onPickImage, required this.onSaveImage, required this.onDeleteImage,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(onPressed: onPickImage, icon: Icon(Icons.image_search_outlined,color: Colors.grey,)),
          IconButton(onPressed: onDeleteImage, icon: Icon(Icons.delete_forever_outlined, color:Colors.grey,)),
          IconButton(onPressed: onSaveImage, icon: Icon(Icons.save, color: Colors.grey,)),
        ],
      ),
    );
  }

}
```

## footer 구현
```dart
import 'package:flutter/material.dart';

typedef OnEmoticonTap = void Function(int id);

class Footer extends StatelessWidget {
 final OnEmoticonTap onEmoticonTap;

  const Footer({super.key, required this.onEmoticonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              7,
              (index)=>Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: (){
                  onEmoticonTap(index +1);
                },
                child: Image.asset("asset/img/emoticon_${index+1}.png",height: 100,),
              ),
              )),
        ),
      ),
    );
  }

}
```

## sticker_model 구현
```dart
class StickerModel {
  final String id;
  final String imgPath;

  StickerModel({
    required this.id,
    required this.imgPath,
  });

  @override
  bool operator ==(Object other) {
    return (other as StickerModel).id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

```
