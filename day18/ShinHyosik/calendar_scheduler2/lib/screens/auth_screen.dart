import 'package:calendar_scheduler/components/login_text_field.dart';
import 'package:calendar_scheduler/constants/colors.dart';
import 'package:calendar_scheduler/providers/schedule_provider.dart';
import 'package:calendar_scheduler/screens/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
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
                onSaved: (newValue) {
                  email = newValue!;
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '이메일을 입력해 주세요.';
                  }

                  RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                  if (!regExp.hasMatch(value!)) {
                    return '이메일 형식이 올바르지 않습니다.';
                  }

                  return null;
                },
                hintText: '이메일',
              ),
              const SizedBox(
                height: 8.0,
              ),
              LoginTextField(
                onSaved: (newValue) {
                  password = newValue!;
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '비밀번호를 입력해 주세요.';
                  }

                  if (value!.length < 4 || value.length > 8) {
                    return '비밀번호는 4~8자 사이로 입력해 주세요.';
                  }

                  return null;
                },
                hintText: '비밀번호',
                obscureText: true,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  onRegisterPress(provider);
                },
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
                onPressed: () {
                  onLoginPress(provider);
                },
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
      ),
    );
  }

  bool saveAndValidateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    formKey.currentState!.save();

    return true;
  }

  onRegisterPress(ScheduleProvider provider) async {
    if (!saveAndValidateForm()) {
      return;
    }

    String? message;

    try {
      await provider.register(
        email: email,
        password: password,
      );
    } on DioException catch (e) {
      message = e.response!.data['message'] ?? '알 수 없는 오류 발생.';
    } catch (e) {
      message = '알 수 없는 오류 발생.';
    } finally {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      }
    }
  }

  onLoginPress(ScheduleProvider provider) async {
    if (!saveAndValidateForm()) {
      return;
    }

    String? message;

    try {
      await provider.login(email: email, password: password);
    } on DioException catch (e) {
      message = e.response!.data['message'] ?? '알 수 없는 오류 발생.';
    } catch (e) {
      message = '알 수 없는 오류 발생.';
    } finally {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      }
    }
  }
}
