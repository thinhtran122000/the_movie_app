class AppValidation {
  static final AppValidation _instance = AppValidation._();
  AppValidation._();
  factory AppValidation() => _instance;

  String validateAccount(String username, String password) {
    if (username.trim().isEmpty && password.trim().isEmpty) {
      return 'Please provide your username\nPlease enter your password';
    } else if (username.trim().isEmpty) {
      return 'Please provide your username';
    } else if (password.trim().isEmpty) {
      return 'Please enter your password';
    } else {
      return '';
    }
  }

  String validatePassword(String password) {
    if (password.trim().isEmpty) {
      return 'Please enter your password';
    } else {
      return '';
    }
  }
}
