// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) =>
    UserLogin()..accessToken = json['access-token'] as String?;

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'access-token': instance.accessToken,
    };

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) => UserRegister()
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..id = json['id'] as String?;

Map<String, dynamic> _$UserRegisterToJson(UserRegister instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'id': instance.id,
    };
