// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'created_date', fromJson: _fromJson, toJson: _toJson)
  DateTime? created_date;
  String? email;
  String? mobile_no;
  String? name;
  String? user_image;

  UserModel({
    this.created_date,
    this.email,
    this.mobile_no,
    this.name,
    this.user_image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      created_date: json['created_date'] != null
          ? _fromJson(json['created_date'] as String)
          : null,
      email: json['email'] as String?,
      mobile_no: json['mobile_no'] as String?,
      name: json['name'] as String?,
      user_image: json['user_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_date': _toJson(created_date),
      'email': email,
      'mobile_no': mobile_no,
      'name': name,
      'user_image': user_image,
    };
  }

  // Custom date parsing methods
  static DateTime? _fromJson(String? date) {
    if (date == null || date.isEmpty) return null;
    return DateTime.tryParse(date) ?? _parseCustomDate(date);
  }

  static String? _toJson(DateTime? date) => date?.toIso8601String();

  // Custom date parser for non-ISO date formats
  static DateTime? _parseCustomDate(String date) {
    try {
      return DateTime.parse(date.replaceFirst(RegExp(r'\sGMT$'), 'Z'));
    } catch (e) {
      return null;
    }
  }
}
