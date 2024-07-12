import 'package:calendar_scheduler/components/login_text_field.dart';
import 'package:calendar_scheduler/constants/colors.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * .5,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            LoginTextField(
              onSaved: (newValue) {},
              validator: (value) {},
              hintText: '이메일',
            ),
            const SizedBox(
              height: 8.0,
            ),
            LoginTextField(
              onSaved: (newValue) {},
              validator: (value) {},
              hintText: '비밀번호',
              obscureText: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('회원가입'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SECONDARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('로그인'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SECONDARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
