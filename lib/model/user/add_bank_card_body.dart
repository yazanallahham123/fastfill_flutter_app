import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_bank_card_body.g.dart';

@JsonSerializable()
class AddBankCardBody extends Equatable {
  final String? bankName;
  final String? cardNumber;
  final String? expiryDate;

  const AddBankCardBody(
      {
        this.bankName,
        this.cardNumber,
        this.expiryDate});

  factory AddBankCardBody.fromJson(Map<String, dynamic> json) => _$AddBankCardBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddBankCardBodyToJson(this);

  @override
  List<Object?> get props => [
    this.bankName,
    this.cardNumber,
    this.expiryDate
  ];
}