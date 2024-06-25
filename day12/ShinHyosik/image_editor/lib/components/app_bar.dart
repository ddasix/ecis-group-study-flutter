import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final VoidCallback onPickImage;
  final VoidCallback onDeleteItem;
  final VoidCallback onSaveImage;

  const MainAppBar({
    super.key,
    required this.onPickImage,
    required this.onDeleteItem,
    required this.onSaveImage,
  });

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
          IconButton(
            onPressed: onPickImage,
            icon: Icon(
              Icons.image_search_outlined,
              color: Colors.grey[700],
            ),
          ),
          IconButton(
            onPressed: onDeleteItem,
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.grey[700],
            ),
          ),
          IconButton(
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
