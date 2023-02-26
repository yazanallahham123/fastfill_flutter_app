// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUpParam _$TopUpParamFromJson(Map<String, dynamic> json) => TopUpParam(
      paymentUrl: json['paymentUrl'] as String?,
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$TopUpParamToJson(TopUpParam instance) =>
    <String, dynamic>{
      'paymentUrl': instance.paymentUrl,
      'transactionId': instance.transactionId,
    };
