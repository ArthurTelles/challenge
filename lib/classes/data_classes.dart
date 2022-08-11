import 'package:shared_preferences/shared_preferences.dart';

class FormData {
  String input;
  bool showPassword;

  FormData(this.input, this.showPassword);
}

class LoginData {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static String? getAccessToken() => _preferences?.getString('accessToken');

  static Future setAccessToken(String accessToken) async =>
      await _preferences?.setString('accessToken', accessToken);

  String email;
  String password;

  LoginData(this.email, this.password);
}
