import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'syber_pay_check_status_response_payment_body.g.dart';

@JsonSerializable()
class SyberPayCheckStatusResponsePaymentBody extends Equatable {
  final String? status;
  final String? serviceId;
  final double? amount;
  final String? currency;
  final String? customerRef;
  final String? tranTimestamp;
  final String? responseMessage;
  final String? transactionId;

  const SyberPayCheckStatusResponsePaymentBody(
      {this.status,
        this.serviceId,
        this.amount,
        this.currency,
        this.customerRef,
        this.tranTimestamp,
        this.responseMessage,
        this.transactionId});

  factory SyberPayCheckStatusResponsePaymentBody.fromJson(Map<String, dynamic> json) => _$SyberPayCheckStatusResponsePaymentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SyberPayCheckStatusResponsePaymentBodyToJson(this);

  @override
  List<Object?> get props => [
    this.status,
    this.serviceId,
    this.amount,
    this.currency,
    this.customerRef,
    this.tranTimestamp,
    this.responseMessage,
    this.transactionId
  ];
}