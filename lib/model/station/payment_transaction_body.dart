import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_transaction_body.g.dart';

@JsonSerializable()
class PaymentTransactionBody extends Equatable {
  final int? userId;
  final String? date;
  final int? companyId;
  final int? fuelTypeId;
  final double? amount;
  final double? fastfill;
  final bool? status;

  const PaymentTransactionBody(
      {this.userId,
        this.date,
        this.companyId,
        this.fuelTypeId,
        this.amount,
        this.fastfill,
        this.status});

  factory PaymentTransactionBody.fromJson(Map<String, dynamic> json) => _$PaymentTransactionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionBodyToJson(this);

  @override
  List<Object?> get props => [
    this.userId,
    this.date,
    this.companyId,
    this.fuelTypeId,
    this.amount,
    this.fastfill,
    this.status
  ];
}