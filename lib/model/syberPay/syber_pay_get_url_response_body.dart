import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'syber_pay_get_url_response_body.g.dart';

@JsonSerializable()
class SyberPayGetUrlResponseBody extends Equatable {
  final String? status;
  final String? hash;
  final String? applicationId;
  final String? serviceId;
  final double? amount;
  final String? currency;
  final String? customerRef;
  final String? tranTimestamp;
  final int? responseCode;
  final String? responseMessage;
  final String? paymentUrl;
  final String? transactionId;

  const SyberPayGetUrlResponseBody(
      {this.status,
        this.hash,
        this.applicationId,
        this.serviceId,
        this.amount,
        this.currency,
        this.customerRef,
        this.tranTimestamp,
        this.responseCode,
        this.responseMessage,
        this.paymentUrl,
        this.transactionId
        });

  factory SyberPayGetUrlResponseBody.fromJson(Map<String, dynamic> json) => _$SyberPayGetUrlResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SyberPayGetUrlResponseBodyToJson(this);

  @override
  List<Object?> get props => [
    this.status,
    this.hash,
    this.applicationId,
    this.serviceId,
    this.amount,
    this.currency,
    this.customerRef,
    this.tranTimestamp,
    this.responseCode,
    this.responseMessage,
    this.paymentUrl,
    this.transactionId
  ];
}