import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

// Function created to give better feedback of the current user state avoiding
// a new request to get the user token.
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String generateRandomAccessToken(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );

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

class RegisterData {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAccessToken() async => await _preferences?.setString(
        'accessToken',
        generateRandomAccessToken(64),
      );

  String name;
  String email;
  String password;
  String passwordConfirm;

  RegisterData(this.name, this.email, this.password, this.passwordConfirm);

  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}

class PaintsData {
  String id;
  String name;
  String price;
  bool deliveryFree;
  String coverImage;
  String description;

  PaintsData(
    this.id,
    this.name,
    this.price,
    this.deliveryFree,
    this.coverImage,
    this.description,
  );
}
