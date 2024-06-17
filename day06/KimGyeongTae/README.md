# 앱을 만들며 유용한 기능 익히기
## 9. 전자액자
### 9.1 사전 지식
#### 9.1.1 위젯 생명주기
- StatelessWidget
  - 상태가 없는 위젯
  - 생명주기는 먼저 해당 위젯이 빌드되면 생성자가 실행
  - 이어서 필수로 오버라이드 해야 하는 build() 함수가 실행
  - 마지막으로 build() 함수에 반환한 위젯이 화면에 렌더링
  - StatelessWidget 의 build() 함수는 재실행 되지 않는다.
- StatefulWidget
  - 상태 변경이 없는 생명주기
    - 상태변경이 없는 생명주기는 나타나고 사라지기까지 중간에 위젯의 상태가 변경되지 않는다.
    - 1) StatefulWidget 생성자가 실행
    - 2) createState() 함수가 실행, StatefulWidget 과 연동되는 State 를 생성
    - 3) State 가 생성되면 initState() 가 실행
    - 4) didChangeDependencies() 가 실행
    - 5) State 의 상태가 dirty 로 설정
    - 6) dirty 로 인해 build() 가 재실행되고, 화면에 반영
    - 7) build 가 완료되면 clean 상태가 된다
    - 8) 위젯이 위젯트리에서 사라지면 deactivate() 가 실행
    - 9) 위젯이 영구적으로 삭제될 때 dispose() 가 실행
  - 생성자의 매개변수가 변경되었을 때 생명주기
    - 1) StatefulWidget 생성자가 실행
    - 2) State 의 didUpdateWidget() 함수가 실행
    - 3) State 가 dirty 상태로 변경
    - 4) build() 가 실행
    - 5) State 의 상태가 clean 으로 변경
  - State 자체적으로 build() 를 재실행할 때 생명주기
    - 1) State 클래스의 setState() 를 실행
    - 2) State 가 dirty 상태로 변경
    - 3) build() 가 실행
    - 4) State 의 상태가 clean 으로 변경
    
#### 9.1.2 Timer
- 특정 시간이 지난 후에 일회성 또는 지속적으로 함수를 실행
  - Timer() : 기본 생성자
  - Timer.periodic() : Timer 의 유일한 네임드 생성자
### 9.4 구현하기
- main.dart
    ```dart
    import 'package:ch09/screen/home_screen.dart';
    import 'package:flutter/material.dart';

    void main() {
      runApp(
        MaterialApp(
          home: HomeScreen(),
        ),
      );
    }
    ```
- home_screen.dart
    ```dart
    import 'package:flutter/material.dart';
    import 'dart:async';

    class HomeScreen extends StatefulWidget {
      const HomeScreen({Key? key}) : super(key: key);

      @override
      State<HomeScreen> createState() => _HomeScreenState();
    }

    class _HomeScreenState extends State<HomeScreen> {
      final PageController pageController = PageController();

      @override
      void initState() {
        super.initState();
        
        Timer.periodic(Duration(seconds: 3), (timer) {
          int? nextPage = pageController.page?.toInt();

          if (nextPage == null) {
            return;
          }

          if (nextPage == 4) {
            nextPage = 0;
          } else {
            nextPage += 1;
          }
          
          pageController.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: PageView(
            controller: pageController,

            children: [1, 2, 3, 4, 5]
                .map((number) => Image.asset(
                      'asset/img/image_$number.jpeg',
                      fit: BoxFit.cover,
                    ))
                .toList(),
          ),
        );
      }
    }
    ```