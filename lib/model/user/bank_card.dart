import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_card.g.dart';

@JsonSerializable()
class BankCard extends Equatable {
  final int? id;
  final int? userId;
  final String? bankName;
  final String? cardNumber;

  const BankCard(
      {this.id,
        this.userId,
        this.bankName,
        this.cardNumber});

  factory BankCard.fromJson(Map<String, dynamic> json) => _$BankCardFromJson(json);

  Map<String, dynamic> toJson() => _$BankCardToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.userId,
    this.bankName,
    this.cardNumber
  ];
}