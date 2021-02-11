class Config {
  static const String _serviceBaseUrl =
      "https://collegem820210207221016.azurewebsites.net/api";

  static const String _userUrl = "/User";
  static const String _loginUrl = "/User/login";
  static const String _changePasswordUrl = "/User/changepassword";

  static String loginUrl = _serviceBaseUrl + _loginUrl;
  static String userUrl = _serviceBaseUrl + _userUrl;
  static String changePasswordUrl = _serviceBaseUrl + _changePasswordUrl;
}
