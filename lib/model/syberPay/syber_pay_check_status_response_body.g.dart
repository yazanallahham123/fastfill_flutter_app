// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syber_pay_check_status_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyberPayCheckStatusResponseBody _$SyberPayCheckStatusResponseBodyFromJson(
        Map<String, dynamic> json) =>
    SyberPayCheckStatusResponseBody(
      status: json['status'] as String?,
      applicationId: json['applicationId'] as String?,
      transactionId: json['transactionId'] as String?,
      tranTimestamp: json['tranTimestamp'] as String?,
      responseCode: json['responseCode'] as int?,
      responseMessage: json['responseMessage'] as String?,
      payment: json['payment'] == null
          ? null
          : SyberPayCheckStatusResponsePaymentBody.fromJson(
              json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SyberPayCheckStatusResponseBodyToJson(
        SyberPayCheckStatusResponseBody instance) =>
    <String, dynamic>{
      'status': instance.status,
      'applicationId': instance.applicationId,
      'transactionId': instance.transactionId,
      'tranTimestamp': instance.tranTimestamp,
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
      'payment': instance.payment,
    };
