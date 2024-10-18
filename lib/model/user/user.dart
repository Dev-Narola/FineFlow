// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  final String mobile_no;
  final String password;
  String? userImage;

  User(
      {required this.name,
      required this.email,
      required this.mobile_no,
      required this.password,
      this.userImage});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
