abstract class FieldsValidator{

  bool isEmailValid(String email);

  bool isPswValid(String psw);

  bool pswHas8Char(String psw);

  bool pswHasUpperCase(String psw);

  bool pswHasLowerCase(String psw);

  bool pswHasNumber(String psw);

  bool pswHasSpecialChar(String psw);
}