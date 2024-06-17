import 'package:flutter/material.dart';
import 'package:video_web_rtc/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Logo(),
              ),
              Expanded(
                child: MyImage(),
              ),
              Expanded(
                child: EntryButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
