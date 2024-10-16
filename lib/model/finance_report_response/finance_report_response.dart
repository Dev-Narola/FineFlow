import 'package:json_annotation/json_annotation.dart';

part 'finance_report_response.g.dart';

@JsonSerializable()
class FinanceReportResponse {
  final String message;
  final String? reportid;

  FinanceReportResponse({
    required this.message,
    this.reportid,
  });

  factory FinanceReportResponse.fromJson(Map<String, dynamic> json) =>
      _$FinanceReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceReportResponseToJson(this);
}
