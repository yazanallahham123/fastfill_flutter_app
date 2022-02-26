import 'package:equatable/equatable.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_transaction_result.g.dart';

@JsonSerializable()
class PaymentTransactionResult extends Equatable {
  final int? id;
  final StationBranch? companyBranch;
  final int? userId;
  final String? date;
  final int? companyBranchId;
  final int? fuelTypeId;
  final double? amount;
  final double? fastfill;
  final bool? status;

  const PaymentTransactionResult(
      {this.id,
        this.companyBranch,
        this.userId,
        this.date,
        this.companyBranchId,
        this.fuelTypeId,
        this.amount,
        this.fastfill,
        this.status

      });

  factory PaymentTransactionResult.fromJson(Map<String, dynamic> json) => _$PaymentTransactionResultFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionResultToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.companyBranch,
    this.userId,
    this.date,
    this.companyBranchId,
    this.fuelTypeId,
    this.amount,
    this.fastfill,
    this.status
  ];
}