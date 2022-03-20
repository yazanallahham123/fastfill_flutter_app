// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransactionResult _$PaymentTransactionResultFromJson(
        Map<String, dynamic> json) =>
    PaymentTransactionResult(
      id: json['id'] as int?,
      company: json['company'] == null
          ? null
          : Station.fromJson(json['company'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      companyId: json['companyId'] as int?,
      fuelTypeId: json['fuelTypeId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      fastfill: (json['fastfill'] as num?)?.toDouble(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$PaymentTransactionResultToJson(
        PaymentTransactionResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'userId': instance.userId,
      'date': instance.date,
      'companyId': instance.companyId,
      'fuelTypeId': instance.fuelTypeId,
      'amount': instance.amount,
      'fastfill': instance.fastfill,
      'status': instance.status,
    };
