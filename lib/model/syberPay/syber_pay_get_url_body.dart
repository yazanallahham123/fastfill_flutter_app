import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'syber_pay_get_url_body.g.dart';

@JsonSerializable()
class SyberPayGetUrlBody extends Equatable {
  final String? applicationId;
  final String? serviceId;
  final String? customerRef;
  final double? amount;
  final String? currency;
  final String? hash;

  const SyberPayGetUrlBody(
      {this.applicationId,
        this.serviceId,
        this.customerRef,
        this.amount,
        this.currency,
        this.hash});

  factory SyberPayGetUrlBody.fromJson(Map<String, dynamic> json) => _$SyberPayGetUrlBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SyberPayGetUrlBodyToJson(this);

  @override
  List<Object?> get props => [
    this.applicationId,
    this.serviceId,
    this.customerRef,
    this.amount,
    this.currency,
    this.hash
  ];
}