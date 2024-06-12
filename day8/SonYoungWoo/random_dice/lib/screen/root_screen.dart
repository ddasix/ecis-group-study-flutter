import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';
import 'package:u_and_i/screen/settings_screen.dart';
import 'dart:math';
import 'package:shake/shake.dart';


class RootScreen extends StatefulWidget{

  const RootScreen({super.key});
 
  @override
  State<StatefulWidget> createState() => _RootScreenState();

}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  @override
  void initState()
  {
    super.initState();

    controller = TabController(length: 2, vsync: this);
    controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
        shakeSlopTimeMS: 100,
        shakeThresholdGravity: threshold,
        onPhoneShake: onPhoneShake,);

  }

  void onPhoneShake(){
    final rand = new Random();
    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() {  // ➋ listener로 사용할 함수
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  TabBarView(
        controller: controller,
        children: renderChildren(),
        ),
        bottomNavigationBar: renderBottomNavigation(),
    );
  }

 
 List<Widget> renderChildren(){
  return [
    HomeScreen(number: number),
    SettingsScreen(threshold: threshold, onThresholdChange: onThresholdChange),
  ];
 }

 void onThresholdChange(double val)
 {
   setState(() {
     threshold = val;
   });
 }

 BottomNavigationBar renderBottomNavigation(){
   return BottomNavigationBar(
     currentIndex: controller!.index,
     onTap: (int index){
       setState(() {
         controller!.animateTo(index);
       });
     },
     items: const [
       BottomNavigationBarItem(icon: Icon(
         Icons.edgesensor_high_outlined,
       ),
         label: "주사위",
       ),
       BottomNavigationBarItem(icon: Icon(
         Icons.settings,
       ),
         label: "설정",
       ),
     ],
   );
 }
}

 
