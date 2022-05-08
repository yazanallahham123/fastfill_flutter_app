// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankCard _$BankCardFromJson(Map<String, dynamic> json) => BankCard(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      bankName: json['bankName'] as String?,
      cardNumber: json['cardNumber'] as String?,
    );

Map<String, dynamic> _$BankCardToJson(BankCard instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'bankName': instance.bankName,
      'cardNumber': instance.cardNumber,
    };
