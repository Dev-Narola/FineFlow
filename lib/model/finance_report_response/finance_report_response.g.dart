// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceReportResponse _$FinanceReportResponseFromJson(
        Map<String, dynamic> json) =>
    FinanceReportResponse(
      message: json['message'] as String,
      reportid: json['reportid'] as String?,
    );

Map<String, dynamic> _$FinanceReportResponseToJson(
        FinanceReportResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'reportid': instance.reportid,
    };
