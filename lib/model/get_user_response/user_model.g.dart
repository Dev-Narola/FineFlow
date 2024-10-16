// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobileNo: json['mobileNo'] as String?,
      userImage: json['userImage'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobileNo': instance.mobileNo,
      'userImage': instance.userImage,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
