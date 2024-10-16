import 'package:json_annotation/json_annotation.dart';

part 'finance_report_model.g.dart';

@JsonSerializable()
class FinanceReportModel {
  final String name;
  final String merchant_name;
  final double amount;
  final String date;
  final String? description;
  final String category;
  final String? bill_image;
  final double? tax;

  FinanceReportModel({
    required this.name,
    required this.merchant_name,
    required this.amount,
    required this.date,
    required this.description,
    required this.category,
    this.bill_image,
    this.tax,
  });

  factory FinanceReportModel.fromJson(Map<String, dynamic> json) =>
      _$FinanceReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceReportModelToJson(this);
}
