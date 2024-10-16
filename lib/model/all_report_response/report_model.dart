import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  @JsonKey(name: '_id')
  String? id;
  double? amount;
  String? billImage;
  String? category;
  String? createdDate;
  String? date;
  String? description;
  String? merchantName;
  String? name;
  double? tax;
  @JsonKey(name: 'user_id')
  String? userId;

  ReportModel({
    this.id,
    this.amount,
    this.billImage,
    this.category,
    this.createdDate,
    this.date,
    this.description,
    this.merchantName,
    this.name,
    this.tax,
    this.userId,
  });

  // Factory constructor to create the object from JSON
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
