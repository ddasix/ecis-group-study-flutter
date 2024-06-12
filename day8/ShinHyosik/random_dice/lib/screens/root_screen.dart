import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice/widgets/home.dart';
import 'package:random_dice/widgets/setting.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  late final TabController controller;
  late final ShakeDetector shakeDetector;
  double threshold = 2.7;
  int diceNumber = 1;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 2,
      vsync: this,
    );

    controller.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100,
      shakeThresholdGravity: threshold,
      onPhoneShake: onPhoneShake,
    );
  }

  void tabListener() {
    setState(() {});
  }

  void onThresholdChange(double thres) {
    setState(() {
      threshold = thres;
    });
  }

  void onPhoneShake() {
    final rand = Random();

    setState(() {
      diceNumber = rand.nextInt(5) + 1;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    shakeDetector.stopListening();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: _tabBarItem(),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  List<Widget> _tabBarItem() {
    return [
      HomeWidget(
        number: diceNumber,
      ),
      SettingWidget(
        onThresholdChange: onThresholdChange,
        threshold: threshold,
      )
    ];
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller.index,
      onTap: (value) {
        setState(() {
          controller.animateTo(value);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }
}
