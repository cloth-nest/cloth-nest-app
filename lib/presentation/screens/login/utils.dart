extension PasswordValidator on String {
  bool isValidPassword() {
    RegExp regex = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$");
    return regex.hasMatch(this);
  }
}
