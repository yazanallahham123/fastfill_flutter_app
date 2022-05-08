// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syber_pay_get_url_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyberPayGetUrlBody _$SyberPayGetUrlBodyFromJson(Map<String, dynamic> json) =>
    SyberPayGetUrlBody(
      applicationId: json['applicationId'] as String?,
      serviceId: json['serviceId'] as String?,
      customerRef: json['customerRef'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      hash: json['hash'] as String?,
    );

Map<String, dynamic> _$SyberPayGetUrlBodyToJson(SyberPayGetUrlBody instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'serviceId': instance.serviceId,
      'customerRef': instance.customerRef,
      'amount': instance.amount,
      'currency': instance.currency,
      'hash': instance.hash,
    };
