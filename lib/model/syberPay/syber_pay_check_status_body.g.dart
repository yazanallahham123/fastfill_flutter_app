// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syber_pay_check_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyberPayCheckStatusBody _$SyberPayCheckStatusBodyFromJson(
        Map<String, dynamic> json) =>
    SyberPayCheckStatusBody(
      applicationId: json['applicationId'] as String?,
      transactionId: json['transactionId'] as String?,
      hash: json['hash'] as String?,
    );

Map<String, dynamic> _$SyberPayCheckStatusBodyToJson(
        SyberPayCheckStatusBody instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'transactionId': instance.transactionId,
      'hash': instance.hash,
    };
