// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syber_pay_get_url_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyberPayGetUrlResponseBody _$SyberPayGetUrlResponseBodyFromJson(
        Map<String, dynamic> json) =>
    SyberPayGetUrlResponseBody(
      status: json['status'] as String?,
      hash: json['hash'] as String?,
      applicationId: json['applicationId'] as String?,
      serviceId: json['serviceId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      customerRef: json['customerRef'] as String?,
      tranTimestamp: json['tranTimestamp'] as String?,
      responseCode: json['responseCode'] as int?,
      responseMessage: json['responseMessage'] as String?,
      paymentUrl: json['paymentUrl'] as String?,
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$SyberPayGetUrlResponseBodyToJson(
        SyberPayGetUrlResponseBody instance) =>
    <String, dynamic>{
      'status': instance.status,
      'hash': instance.hash,
      'applicationId': instance.applicationId,
      'serviceId': instance.serviceId,
      'amount': instance.amount,
      'currency': instance.currency,
      'customerRef': instance.customerRef,
      'tranTimestamp': instance.tranTimestamp,
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
      'paymentUrl': instance.paymentUrl,
      'transactionId': instance.transactionId,
    };
