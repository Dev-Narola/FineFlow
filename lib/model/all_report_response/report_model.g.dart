// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      billImage: json['billImage'] as String?,
      category: json['category'] as String?,
      createdDate: json['createdDate'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      merchantName: json['merchantName'] as String?,
      name: json['name'] as String?,
      tax: (json['tax'] as num?)?.toDouble(),
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'amount': instance.amount,
      'billImage': instance.billImage,
      'category': instance.category,
      'createdDate': instance.createdDate,
      'date': instance.date,
      'description': instance.description,
      'merchantName': instance.merchantName,
      'name': instance.name,
      'tax': instance.tax,
      'user_id': instance.userId,
    };
