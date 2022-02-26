// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResultBody _$PaymentResultBodyFromJson(Map<String, dynamic> json) =>
    PaymentResultBody(
      date: json['date'] as String,
      stationName: json['stationName'] as String,
      fuelTypeId: json['fuelTypeId'] as int,
      amount: (json['amount'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      status: json['status'] as bool,
      fromList: json['fromList'] as bool,
    );

Map<String, dynamic> _$PaymentResultBodyToJson(PaymentResultBody instance) =>
    <String, dynamic>{
      'date': instance.date,
      'stationName': instance.stationName,
      'fuelTypeId': instance.fuelTypeId,
      'amount': instance.amount,
      'value': instance.value,
      'status': instance.status,
      'fromList': instance.fromList,
    };
