// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransactionResult _$PaymentTransactionResultFromJson(
        Map<String, dynamic> json) =>
    PaymentTransactionResult(
      id: json['id'] as int?,
      companyBranch: json['companyBranch'] == null
          ? null
          : StationBranch.fromJson(
              json['companyBranch'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      companyBranchId: json['companyBranchId'] as int?,
      fuelTypeId: json['fuelTypeId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      fastfill: (json['fastfill'] as num?)?.toDouble(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$PaymentTransactionResultToJson(
        PaymentTransactionResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyBranch': instance.companyBranch,
      'userId': instance.userId,
      'date': instance.date,
      'companyBranchId': instance.companyBranchId,
      'fuelTypeId': instance.fuelTypeId,
      'amount': instance.amount,
      'fastfill': instance.fastfill,
      'status': instance.status,
    };
