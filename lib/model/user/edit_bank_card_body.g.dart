// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_bank_card_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditBankCardBody _$EditBankCardBodyFromJson(Map<String, dynamic> json) =>
    EditBankCardBody(
      id: json['id'] as int?,
      bankName: json['bankName'] as String?,
      cardNumber: json['cardNumber'] as String?,
      expiryDate: json['expiryDate'] as String?,
    );

Map<String, dynamic> _$EditBankCardBodyToJson(EditBankCardBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
    };
