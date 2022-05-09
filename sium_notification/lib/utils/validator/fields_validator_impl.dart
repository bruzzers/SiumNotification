import 'package:sium_notification/utils/validator/fields_validator.dart';

class FieldsValidatorImpl extends FieldsValidator{
  @override
  bool isEmailValid(String email) {
    return true;
  }

  @override
  bool isPswValid(String psw) {
    return true;
  }

}