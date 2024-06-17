import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30.0,
      color: Colors.white,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
