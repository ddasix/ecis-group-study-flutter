import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData iconData;

  const CustomIconButton(
      {super.key, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      color: Colors.white,
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
}
