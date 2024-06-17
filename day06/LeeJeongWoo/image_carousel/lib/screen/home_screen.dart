import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';  // async 패키지 불러오기

// // 9.2.3. 프로젝트 초기화하기
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text('Home Screen'),
//     );
//   }
// }

// // 9.4.1 페이지뷰 구현하기
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(   // PageView 추가
//         children: [1, 2, 3, 4, 5]   // 샘플 리스트 생성
//           .map(   // 위젯으로 매핑
//         (number) => Image.asset('asset/img/image_$number.jpeg'),
//             )
//             .toList(),
//       ),  // 'Home Screen'),
//     );
//   }
// }

// // 9.4.1 페이지뷰 구현하기_여백없애기
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(   // map() 함수는 1.4.1 map()을 참조해주세요.
//         children: [1, 2, 3, 4, 5]
//             .map(   // 위젯으로 매핑
//               (number) => Image.asset(
//                   'asset/img/image_$number.jpeg',
//                   fit: BoxFit.cover,  // BoxFit.cover 설정
//               ),
//         )
//             .toList(),
//       ),  // 'Home Screen'),
//     );
//   }
// }

// // 9.4.2 상태바 색상 변경하기
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // 상태바 색상 변경
//     // 상태바가 이미 흰색이면 light 대신 dark를 주어 검정을 바꾸세요.
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//     return Scaffold(
//       body: PageView(   // map() 함수는 1.4.1 map()을 참조해주세요.
//         children: [1, 2, 3, 4, 5]
//             .map(   // 위젯으로 매핑
//               (number) => Image.asset(
//             'asset/img/image_$number.jpeg',
//             fit: BoxFit.cover,  // BoxFit.cover 설정
//           ),
//         )
//             .toList(),
//       ),  // 'Home Screen'),
//     );
//   }
// }

// 9.4.3 타이머 추가하기

// StatefulWidget 정의
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState 정의
class _HomeScreenState extends State<HomeScreen> {
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

  // PageController 생성
  final PageController pageController = PageController();

  // initState() 함수 등록
  @override
  void initState() {
    super.initState();  // 부모 initState() 실행

    Timer.periodic(     // Timer.periodic() 등록
      Duration(seconds: 3),
          (timer) {
          // print('실행!');

        // 현재 페이지 가져오기
        int?nextPage = pageController.page?.toInt();

        if (nextPage == null) {   // 페이지 값이 없을 때 예외 처리
          return;
        }

        if (nextPage == 4) {      // 첫 페이지와 마지막 페이지 분기 처리
          nextPage = 0;
        } else {
          nextPage++;
        }
        pageController.animateToPage( // 페이지 변경
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    // 상태바가 이미 흰색이면 light 대신 dark를 주어 검정을 바꾸세요.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(   // map() 함수는 1.4.1 map()을 참조해주세요.
        controller: pageController,   // PageController 등록
        children: [1, 2, 3, 4, 5]
            .map(   // 위젯으로 매핑
              (number) => Image.asset(
            'asset/img/image_$number.jpeg',
            fit: BoxFit.cover,  // BoxFit.cover 설정
          ),
        )
            .toList(),
      ),
    );
  }
}

