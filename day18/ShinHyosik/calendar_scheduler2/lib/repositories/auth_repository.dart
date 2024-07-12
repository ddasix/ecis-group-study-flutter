import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AuthRepository {
  final _dio = Dio();
  final _targetUrl =
      "http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/auth";

  Future<({String refreshToken, String accessToken})> register({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '$_targetUrl/register/email',
      data: {
        "email": email,
        "password": password,
      },
    );

    return (
      refreshToken: response.data['refreshToken'] as String,
      accessToken: response.data['accessToken'] as String,
    );
  }

  Future<({String refreshToken, String accessToken})> login({
    required String email,
    required String password,
  }) async {
    final emailAndPassword = '$email:$password';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    final encodedText = stringToBase64.encode(emailAndPassword);

    final response = await _dio.post(
      '$_targetUrl/login/email',
      options: Options(
        headers: {
          'authorization': 'Basic $encodedText',
        },
      ),
    );

    return (
      refreshToken: response.data['refreshToken'] as String,
      accessToken: response.data['accessToken'] as String,
    );
  }

  Future<String> rotateRefreshToken({
    required String refreshToken,
  }) async {
    final response = await _dio.post(
      '$_targetUrl/token/refresh',
      options: Options(headers: {
        'authorization': 'Bearer $refreshToken',
      }),
    );

    return response.data['refreshToken'] as String;
  }

  Future<String> rotateAccessToken({
    required String refreshToken,
  }) async {
    final response = await _dio.post(
      '$_targetUrl/token/access',
      options: Options(headers: {
        'authorization': 'Bearer $refreshToken',
      }),
    );

    return response.data['accessToken'] as String;
  }
}
