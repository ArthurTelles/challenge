import 'package:json_annotation/json_annotation.dart';

part 'response_classes.g.dart';

@JsonSerializable()
class UserLogin {
  @JsonKey(name: 'access-token')
  String? accessToken;

  UserLogin();

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}

@JsonSerializable()
class UserRegister {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'id')
  String? id;

  UserRegister();

  factory UserRegister.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
