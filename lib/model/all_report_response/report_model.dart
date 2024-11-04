import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  @JsonKey(name: '_id')
  String? id;

  double? amount;

  @JsonKey(name: 'bill_image')
  String? billImage; // Fix this field name

  String? category;

  @JsonKey(name: 'created_date')
  String? createdDate; // Fix this field name

  String? date;

  String? description;

  @JsonKey(name: 'merchant_name')
  String? merchantName; // Fix this field name

  String? name;

  double? tax;

  @JsonKey(name: 'user_id')
  String? userId;

  String? type;

  ReportModel(
      {this.id,
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
      this.type});

  // Factory constructor to create the object from JSON
  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
