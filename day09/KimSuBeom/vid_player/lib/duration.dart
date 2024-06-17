import 'package:intl/intl.dart';

void main() {
  Duration duration = const Duration(seconds: 192);
  print(duration);

  print(duration.toString().split('.')[0]);
  //.기준 List 반환, 첫번째 값

  print(duration.toString().split('.')[0].split(':').sublist(1, 3).join(':'));
  // 첫번째 값을 다시 : 으로 나누고 인덱스 1~2 까지 가져와 합친 값

  print(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}');
  //해당 시간의 분과 : 분을 뺀 초를 표시

  print(
      '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}');

  print('23'.padLeft(3, '0'));
  print('23'.padRight(3, '0'));

  DateTime dateTime = DateTime(0).add(duration);
  print(DateFormat('mm:ss').format(dateTime));
}
