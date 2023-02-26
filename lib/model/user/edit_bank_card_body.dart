import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_bank_card_body.g.dart';

@JsonSerializable()
class EditBankCardBody extends Equatable {
  final int? id;
  final String? bankName;
  final String? cardNumber;
  final String? expiryDate;

  const EditBankCardBody(
      {
        this.id,
        this.bankName,
        this.cardNumber,
        this.expiryDate});

  factory EditBankCardBody.fromJson(Map<String, dynamic> json) => _$EditBankCardBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditBankCardBodyToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.bankName,
    this.cardNumber,
    this.expiryDate
  ];
}