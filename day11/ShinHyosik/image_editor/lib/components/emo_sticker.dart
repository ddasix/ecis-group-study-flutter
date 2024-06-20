import 'package:flutter/material.dart';

class EmoSticker extends StatefulWidget {
  final VoidCallback onTransform;
  final String imagePath;
  final bool isSelected;
  final bool isHidden;

  const EmoSticker({
    super.key,
    required this.onTransform,
    required this.imagePath,
    required this.isSelected,
    required this.isHidden,
  });

  @override
  State<EmoSticker> createState() => _EmoStickerState();
}

class _EmoStickerState extends State<EmoSticker> {
  double scale = 1.0;
  double hTransform = 0;
  double vTransform = 0;
  double actualScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return widget.isHidden == true
        ? const SizedBox.shrink()
        : Transform(
            transform: Matrix4.identity()
              ..translate(hTransform, vTransform)
              ..scale(scale, scale),
            child: Container(
              decoration: widget.isSelected
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    )
                  : BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.transparent,
                      ),
                    ),
              child: GestureDetector(
                onTap: () => widget.onTransform(),
                onScaleUpdate: (details) {
                  widget.onTransform();

                  setState(() {
                    scale = details.scale * actualScale;
                    vTransform += details.focalPointDelta.dy;
                    hTransform += details.focalPointDelta.dx;
                  });
                },
                onScaleEnd: (details) {
                  actualScale = scale;
                },
                child: Image.asset(widget.imagePath),
              ),
            ),
          );
  }
}
