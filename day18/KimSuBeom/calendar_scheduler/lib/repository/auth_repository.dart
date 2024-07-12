import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthRepository {
  final _dio = Dio();

  final _targetUrl =
      'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/auth';

  Future<({String refreshToken, String accessToken})> register({
    required String email,
    required String password,
  }) async {
    final result = await _dio.post(
      '$_targetUrl/register/email',
      data: {
        'email': email,
        'password': password,
      },
    );

    return (
      refreshToken: result.data['refreshToken'] as String,
      accessToken: result.data['accessToken'] as String
    );
  }

  Future<({String refreshToken, String accessToken})> login({
    required String email,
    required String password,
  }) async {
    final emailAndPassword = '$email:$password'; // 이메일:패스워드 형태로 문자열 타입 구성
    Codec<String, String> stringToBase64 =
        utf8.fuse(base64); // utf8 인코딩으로부터 base64 로 변환할 수 있는 코덱 생성
    final encoded = stringToBase64.encode(emailAndPassword); // base64 로 인코딩

    final result = await _dio.post('$_targetUrl/login/email',
        options: Options(
          headers: {
            'authorization': 'Basic $encoded',
          },
        ));

    return (
      // record 형태로 토큰 반환
      refreshToken: result.data['refreshToken'] as String,
      accessToken: result.data['accessToken'] as String
    );
  }

  Future<String> rotateRefreshToken({
    required String refreshToken,
  }) async {
    //리프레시 토큰을 헤더에 담아서 리프레시토큰 토큰 재발급 URL 에 요청을 보냄
    final result = await _dio.post('$_targetUrl/token/refresh',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ));

    return result.data['refreshToken'] as String;
  }

  Future<String> rotateAcessToken({
    required String refreshToken,
  }) async {
    //리프레시 토큰을 헤더에 담아서 엑세스 토큰 재발급 URL 에 요청을 보냄
    final result = await _dio.post('$_targetUrl/token/acess',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ));

    return result.data['accessToken'] as String;
  }
}
