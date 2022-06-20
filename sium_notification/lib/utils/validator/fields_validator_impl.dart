import 'package:sium_notification/utils/validator/fields_validator.dart';

class FieldsValidatorImpl extends FieldsValidator{
  static final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final pswRegex = RegExp(r"^(?=.*[A-Z]+)(?=.*[!@#$&*]+)(?=.*[0-9]+)(?=.*[a-z]+).{8,}$");
  static final upperCaseRegex = RegExp(r"^(.*[A-Z]+)");
  static final lowerCaseRegex = RegExp(r"^(.*[a-z]+)");
  static final numberRegex = RegExp(r"^(.*[0-9]+)");
  static final specialCharRegex = RegExp(r"^(.*[!@#$&*]+)");

  @override
  bool isEmailValid(String email) {
    return emailRegex.hasMatch(email);
  }

  @override
  bool isPswValid(String psw) {
    return pswRegex.hasMatch(psw);
  }

  @override
  bool pswHas8Char(String psw) {
    return psw.length >= 8;
  }

  @override
  bool pswHasLowerCase(String psw) {
    return lowerCaseRegex.hasMatch(psw);
  }

  @override
  bool pswHasNumber(String psw) {
    return numberRegex.hasMatch(psw);
  }

  @override
  bool pswHasSpecialChar(String psw) {
    return specialCharRegex.hasMatch(psw);
  }

  @override
  bool pswHasUpperCase(String psw) {
    return upperCaseRegex.hasMatch(psw);
  }

}