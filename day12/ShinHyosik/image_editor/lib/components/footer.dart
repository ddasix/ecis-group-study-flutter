import 'package:flutter/material.dart';

typedef OnEmoticonTap = void Function(int id);

class AppFooter extends StatelessWidget {
  final OnEmoticonTap onEmoticonTap;

  const AppFooter({
    super.key,
    required this.onEmoticonTap,
  });

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
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () => onEmoticonTap(index + 1),
                child: Image.asset('assets/images/emoticon_${index + 1}.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
