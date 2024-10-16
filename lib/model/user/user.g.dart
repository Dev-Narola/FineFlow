// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      email: json['email'] as String,
      mobile_no: json['mobile_no'] as String,
      password: json['password'] as String,
      userImage: json['userImage'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobile_no': instance.mobile_no,
      'password': instance.password,
      'userImage': instance.userImage,
    };
