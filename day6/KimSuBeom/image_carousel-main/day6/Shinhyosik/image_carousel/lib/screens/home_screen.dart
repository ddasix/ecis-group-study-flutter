import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  final List<String> images;
  const HomeScreen({super.key, required this.images});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        int? nextpage = pageController.page?.toInt();

        if (nextpage == null) {
          return;
        }

        if (nextpage == 4) {
          nextpage = 0;
        } else {
          nextpage += 1;
        }
        print('Timer.periodic $nextpage');
        pageController.animateToPage(
          nextpage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) => Image.asset(
          'assets/images/${widget.images[index]}',
          fit: BoxFit.cover,
        ),
        itemCount: widget.images.length,
        controller: pageController,
        
      ),
      // body: PageView(
      //   controller: pageController,
      //   children: [1, 2, 3, 4, 5].map(
      //     (number) {
      //       print('Number: $number');
      //       return Image.asset(
      //         'assets/images/image_$number.jpeg',
      //         fit: BoxFit.cover,
      //       );
      //     },
      //   ).toList(),
      // ),
    );
  }
}
