// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_refill_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRefillTransactionDto _$UserRefillTransactionDtoFromJson(
        Map<String, dynamic> json) =>
    UserRefillTransactionDto(
      transactionId: json['transactionId'] as String?,
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$UserRefillTransactionDtoToJson(
        UserRefillTransactionDto instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'date': instance.date,
      'amount': instance.amount,
      'status': instance.status,
    };
