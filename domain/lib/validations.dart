extension EmailValidation on String{
  bool isValidEmail() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

}

class EmailValidationException implements Exception {
}

class PasswordTooShortException implements Exception {
}

class InvalidRequestException implements Exception{

}