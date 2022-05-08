// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syber_pay_check_status_response_payment_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyberPayCheckStatusResponsePaymentBody
    _$SyberPayCheckStatusResponsePaymentBodyFromJson(
            Map<String, dynamic> json) =>
        SyberPayCheckStatusResponsePaymentBody(
          status: json['status'] as String?,
          serviceId: json['serviceId'] as String?,
          amount: (json['amount'] as num?)?.toDouble(),
          currency: json['currency'] as String?,
          customerRef: json['customerRef'] as String?,
          tranTimestamp: json['tranTimestamp'] as String?,
          responseMessage: json['responseMessage'] as String?,
          transactionId: json['transactionId'] as String?,
        );

Map<String, dynamic> _$SyberPayCheckStatusResponsePaymentBodyToJson(
        SyberPayCheckStatusResponsePaymentBody instance) =>
    <String, dynamic>{
      'status': instance.status,
      'serviceId': instance.serviceId,
      'amount': instance.amount,
      'currency': instance.currency,
      'customerRef': instance.customerRef,
      'tranTimestamp': instance.tranTimestamp,
      'responseMessage': instance.responseMessage,
      'transactionId': instance.transactionId,
    };
