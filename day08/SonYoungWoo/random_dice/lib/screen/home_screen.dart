import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:u_and_i/const/colors.dart';

class HomeScreen extends StatelessWidget {
  final int number;

  const HomeScreen({
    super.key,
    required this.number,
  });
  
  @override
  Widget build(BuildContext context) {
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("asset/img/$number.png"),
          ),
          SizedBox(height: 30,),
          Text(
            "행운의 숫자",
             style: TextStyle(
               color: primaryColor,
               fontSize: 20,
               fontWeight: FontWeight.w700
             ),
          ),
          SizedBox(height: 12,),
          Text(
            number.toString(),
            style: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          ),
        ],
      );
  }
 
}

 
 