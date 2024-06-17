import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const Logo({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
