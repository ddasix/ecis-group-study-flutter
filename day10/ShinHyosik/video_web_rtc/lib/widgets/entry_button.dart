import 'package:flutter/material.dart';

import '../screens/cam_screen.dart';

class EntryButton extends StatelessWidget {
  const EntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CamScreen(),
              ),
            );
          },
          child: Text('입장하기'),
        ),
      ],
    );
  }
}
