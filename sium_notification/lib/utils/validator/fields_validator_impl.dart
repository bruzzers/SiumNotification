import 'package:sium_notification/utils/validator/fields_validator.dart';

class FieldsValidatorImpl extends FieldsValidator{
  static final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final pswRegex = RegExp(r"^(?=.*[A-Z]+)(?=.*[!@#$&*]+)(?=.*[0-9]+)(?=.*[a-z]+).{8,}$");

  @override
  bool isEmailValid(String email) {
    return emailRegex.hasMatch(email);
  }

  @override
  bool isPswValid(String psw) {
    return pswRegex.hasMatch(psw);
  }

}