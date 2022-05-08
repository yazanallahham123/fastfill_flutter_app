import 'package:equatable/equatable.dart';
import 'package:fastfill/model/common/pagination_info.dart';
import 'package:fastfill/model/station/payment_transaction_result.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bank_card.dart';

part 'bank_cards_with_pagination.g.dart';

@JsonSerializable()
class BankCardsWithPagination extends Equatable {
  final List<BankCard>? bankCards;
  final PaginationInfo? paginationInfo;

  const BankCardsWithPagination(
      {this.bankCards, this.paginationInfo});

  factory BankCardsWithPagination.fromJson(Map<String, dynamic> json) => _$BankCardsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$BankCardsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.bankCards, this.paginationInfo];

}