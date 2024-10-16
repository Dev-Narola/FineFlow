import 'package:json_annotation/json_annotation.dart';
import 'report_model.dart';

part 'reports_response.g.dart';

@JsonSerializable()
class ReportsResponseModel {
  final String message;
  final List<ReportModel> reports;

  ReportsResponseModel({
    required this.message,
    required this.reports,
  });

  // Factory constructor to create the object from JSON
  factory ReportsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReportsResponseModelFromJson(json);

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() => _$ReportsResponseModelToJson(this);
}
