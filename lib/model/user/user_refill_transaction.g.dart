// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_refill_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRefillTransaction _$UserRefillTransactionFromJson(
        Map<String, dynamic> json) =>
    UserRefillTransaction(
      id: json['id'] as int?,
      transactionId: json['transactionId'] as String?,
      userId: json['userId'] as int?,
      date: json['date'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$UserRefillTransactionToJson(
        UserRefillTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'date': instance.date,
      'amount': instance.amount,
      'status': instance.status,
    };
