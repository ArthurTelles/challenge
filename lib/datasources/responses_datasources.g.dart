// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses_datasources.dart';

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

PaintDifferential _$PaintDifferentialFromJson(Map<String, dynamic> json) =>
    PaintDifferential()
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..paintId = json['paintId'] as String?;

Map<String, dynamic> _$PaintDifferentialToJson(PaintDifferential instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'paintId': instance.paintId,
    };

PaintDifferentials _$PaintDifferentialsFromJson(Map<String, dynamic> json) =>
    PaintDifferentials()
      ..differentials = (json['items'] as List<dynamic>?)
          ?.map((e) => PaintDifferential.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PaintDifferentialsToJson(PaintDifferentials instance) =>
    <String, dynamic>{
      'items': instance.differentials,
    };

PaintImage _$PaintImageFromJson(Map<String, dynamic> json) => PaintImage()
  ..id = json['id'] as String?
  ..paintId = json['paintId'] as String?
  ..image = json['image'] as String?;

Map<String, dynamic> _$PaintImageToJson(PaintImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paintId': instance.paintId,
      'image': instance.image,
    };

PaintImages _$PaintImagesFromJson(Map<String, dynamic> json) => PaintImages()
  ..images = (json['items'] as List<dynamic>?)
      ?.map((e) => PaintImage.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PaintImagesToJson(PaintImages instance) =>
    <String, dynamic>{
      'items': instance.images,
    };

ProfileInfoRequest _$ProfileInfoRequestFromJson(Map<String, dynamic> json) =>
    ProfileInfoRequest()
      ..name = json['name'] as String?
      ..email = json['email'] as String?
      ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$ProfileInfoRequestToJson(ProfileInfoRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
    };

CartInfoRequest _$CartInfoRequestFromJson(Map<String, dynamic> json) =>
    CartInfoRequest()
      ..items = (json['items'] as List<dynamic>?)
          ?.map((e) => CartInfo.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CartInfoRequestToJson(CartInfoRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

CartInfo _$CartInfoFromJson(Map<String, dynamic> json) => CartInfo()
  ..id = json['id'] as String?
  ..quantity = json['quantity'] as int?
  ..paint = json['paint'] == null
      ? null
      : Paint.fromJson(json['paint'] as Map<String, dynamic>);

Map<String, dynamic> _$CartInfoToJson(CartInfo instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'paint': instance.paint,
    };
