// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceReportModel _$FinanceReportModelFromJson(Map<String, dynamic> json) =>
    FinanceReportModel(
      name: json['name'] as String,
      merchant_name: json['merchant_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: json['date'] as String,
      description: json['description'] as String?,
      category: json['category'] as String,
      bill_image: json['bill_image'] as String?,
      tax: (json['tax'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FinanceReportModelToJson(FinanceReportModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'merchant_name': instance.merchant_name,
      'amount': instance.amount,
      'date': instance.date,
      'description': instance.description,
      'category': instance.category,
      'bill_image': instance.bill_image,
      'tax': instance.tax,
    };
