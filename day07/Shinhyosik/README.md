# 만난 지 며칠 U&I

## 사전지식

### `setState()` 함수 실행 시 생명주기

1. `StatefulWidget`의 랜더링이 끝나고 클린상태
2. `setState()`를 실행하여 원하는 속성들의 값을 변경
3. `dirty` 상태가 됨
4. Widget이 다시 `build()` 되면서 화면이 랜더링 됨
5. `dirty` -> `clean` 상태가 됨

```dart
setState(() {
    number += 1;
});

```

### `showCupertinoDialog()` 함수

```dart
import 'package:flutter/cupertino.dart';    // Cupertino UI 패키지

showCupertinoDialog(
    context: context, // 가장 가까운 BuildContext
    barrierDismissible: true, // 외부 탭으로 Dialog 닫기 여부
    builder: (context) {
        return Text('Dialog');  // Dialog에 들어갈 위젯을 반환
    },
);
```
- `showDialog`: 다이얼로그를 실행하는 함수
- `Cupertino` IOS의 UI/UX 스타일, 위젯의 모든 UI/UX가 IOS 스타일로 작동 함.

