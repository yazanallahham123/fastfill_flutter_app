import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_refill_transaction.g.dart';

@JsonSerializable()
class UserRefillTransaction extends Equatable {
  final int? id;
  final String? transactionId;
  final int? userId;
  final String? date;
  final double? amount;
  final bool? status;

  const UserRefillTransaction(
      {this.id,
        this.transactionId,
        this.userId,
        this.date,
        this.amount,
        this.status});

  factory UserRefillTransaction.fromJson(Map<String, dynamic> json) => _$UserRefillTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefillTransactionToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.transactionId,
    this.userId,
    this.date,
    this.amount,
    this.status
  ];
}