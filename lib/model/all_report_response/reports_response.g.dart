// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportsResponseModel _$ReportsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReportsResponseModel(
      message: json['message'] as String,
      reports: (json['reports'] as List<dynamic>)
          .map((e) => ReportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportsResponseModelToJson(
        ReportsResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'reports': instance.reports,
    };
