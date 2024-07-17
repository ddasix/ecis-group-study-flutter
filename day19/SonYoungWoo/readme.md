# Chapter 22. 소셜로그인과 파이어베이스 인증하기
## 사전지식
### 소셜 로그인과 OAuth 2.0
- 소셜로그인의 이점
  1. 사용자가 비밀번호를 기억해야하는 번거러움 감소
  2. 회원가입 절차 간소
  3. 가짜계정 생성 방지
  4. 리소스 절약
- OAuth 2.0은 인증을 위한 개방형 표준 프로토콜, 소셜 로그인 프로바이더에 앱을 등록
  1. 소셜 로그인 요청
  2. 소셜 로그인 창
  3. 허가 승인
  4. 리다이렉트 url 혹은 인증코드 전송
  5. 소셜 서버이 토큰 발행 url로 인증코드,클라이언트id,클라이언트 secret 보내면 엑세스 토큰 획득

## 사전준비
### java 11 설정
- 오라클 jdk 다운로드 사이트에서 jdk 11 설치
- signing report 가져오기
- 파이어베이스에서 OAuth 설정. 
### 플러터 템플릿 설치
- ch22/calendar_scheduler_template 실행 및 진행

## auth_screen 구현
```dart
import 'package:calendar_schedule/const/colors.dart';
import 'package:calendar_schedule/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Image.asset(
                  'assets/img/logo.png',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => onGoogleLoginPress(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: SECONDARY_COLOR,
              ),
              child: Text('구글로 로그인'),
            ),
          ],
        ),
      ),
    );
  }

  onGoogleLoginPress(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await account?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final result = await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }
}

```
##
