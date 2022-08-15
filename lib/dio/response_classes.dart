import 'dart:convert';

import 'package:flutter/material.dart';
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

@JsonSerializable()
class Paint {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'price')
  String? price;

  @JsonKey(name: 'deliveryFree')
  bool? deliveryFree;

  @JsonKey(name: 'coverImage')
  String? coverImage;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'id')
  String? id;

  Paint();

  factory Paint.fromJson(Map<String, dynamic> json) => _$PaintFromJson(json);

  Map<String, dynamic> toJson() => _$PaintToJson(this);
}

@JsonSerializable()
class Paints {
  @JsonKey(name: 'items')
  List<Paint>? paints;

  Paints();

  factory Paints.fromJson(Map<String, dynamic> json) => _$PaintsFromJson(json);
  Map<String, dynamic> toJson() => _$PaintsToJson(this);
}
