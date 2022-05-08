import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_refill_transaction_dto.g.dart';

@JsonSerializable()
class UserRefillTransactionDto extends Equatable {
  final String? transactionId;
  final int? userId;
  final String? date;
  final double? amount;
  final bool? status;

  const UserRefillTransactionDto(
      {
        this.transactionId,
        this.userId,
        this.date,
        this.amount,
        this.status});

  factory UserRefillTransactionDto.fromJson(Map<String, dynamic> json) => _$UserRefillTransactionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefillTransactionDtoToJson(this);

  @override
  List<Object?> get props => [
    this.transactionId,
    this.userId,
    this.date,
    this.amount,
    this.status
  ];
}