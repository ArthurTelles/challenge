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

Paint _$PaintFromJson(Map<String, dynamic> json) => Paint()
  ..name = json['name'] as String?
  ..price = json['price'] as String?
  ..deliveryFree = json['deliveryFree'] as bool?
  ..coverImage = json['coverImage'] as String?
  ..description = json['description'] as String?
  ..id = json['id'] as String?;

Map<String, dynamic> _$PaintToJson(Paint instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'deliveryFree': instance.deliveryFree,
      'coverImage': instance.coverImage,
      'description': instance.description,
      'id': instance.id,
    };

Paints _$PaintsFromJson(Map<String, dynamic> json) => Paints()
  ..paints = (json['items'] as List<dynamic>?)
      ?.map((e) => Paint.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PaintsToJson(Paints instance) => <String, dynamic>{
      'items': instance.paints,
    };
