import 'package:dio/dio.dart';

void main() async {
  final getResp = Dio().get('http://test.codefactory.ai');
  final postResp = Dio().post('http://test.codefactory.ai');
  final putResp = Dio().put('http://test.codefactory.ai');
  final deleteResp = Dio().delete('http://test.codefactory.ai');
}
