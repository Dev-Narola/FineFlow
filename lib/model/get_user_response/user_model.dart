import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? email;
  String? mobileNo;
  String? userImage;
  DateTime? createdDate;

  UserModel({
    this.name,
    this.email,
    this.mobileNo,
    this.userImage,
    this.createdDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
