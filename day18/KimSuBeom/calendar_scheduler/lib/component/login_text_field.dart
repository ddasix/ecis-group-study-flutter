import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final FormFieldSetter<String?> onSaved;
  final FormFieldValidator<String?> validator;
  final String? hintText;
  final bool obscureText;

  const LoginTextField({
    super.key,
    required this.onSaved,
    required this.validator,
    this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      cursorColor: SECONDARY_COLOR,
      obscureText: obscureText, // 비밀번호 입력시 사용
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          //활성화 상태 : 텍스트 필드에 값을 입력할 수 있는 상태
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: TEXT_FIELD_FILL_COLOR,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // 탭하면 보더가 포커스 되면서 커서가 활성화
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: SECONDARY_COLOR,
          ),
        ),
        errorBorder: OutlineInputBorder(
          // validator 함수의 유효성 통과 못한 상태
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          borderSide: const BorderSide(
            color: ERROR_COLOR,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // 포커스된 상태에서 에러가 난 상태
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: ERROR_COLOR,
          ),
        ),
      ),
    );
  }
}
