import 'package:equatable/equatable.dart';
import 'package:fastfill/model/syberPay/syber_pay_check_status_response_payment_body.dart';
import 'package:json_annotation/json_annotation.dart';

part 'syber_pay_check_status_response_body.g.dart';

@JsonSerializable()
class SyberPayCheckStatusResponseBody extends Equatable {
  final String? status;
  final String? applicationId;
  final String? transactionId;
  final String? tranTimestamp;
  final int? responseCode;
  final String? responseMessage;
  final SyberPayCheckStatusResponsePaymentBody? payment;


  const SyberPayCheckStatusResponseBody(
      {this.status,
        this.applicationId,
        this.transactionId,
        this.tranTimestamp,
        this.responseCode,
        this.responseMessage,
        this.payment});

  factory SyberPayCheckStatusResponseBody.fromJson(Map<String, dynamic> json) => _$SyberPayCheckStatusResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SyberPayCheckStatusResponseBodyToJson(this);

  @override
  List<Object?> get props => [
    this.status,
    this.applicationId,
    this.transactionId,
    this.tranTimestamp,
    this.responseCode,
    this.responseMessage,
    this.payment
  ];
}