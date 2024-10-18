// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      created_date: UserModel._fromJson(json['created_date'] as String?),
      email: json['email'] as String?,
      mobile_no: json['mobile_no'] as String?,
      name: json['name'] as String?,
      user_image: json['user_image'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'created_date': UserModel._toJson(instance.created_date),
      'email': instance.email,
      'mobile_no': instance.mobile_no,
      'name': instance.name,
      'user_image': instance.user_image,
    };
