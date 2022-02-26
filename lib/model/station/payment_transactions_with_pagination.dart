import 'package:equatable/equatable.dart';
import 'package:fastfill/model/common/pagination_info.dart';
import 'package:fastfill/model/station/payment_transaction_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_transactions_with_pagination.g.dart';

@JsonSerializable()
class PaymentTransactionsWithPagination extends Equatable {
  final List<PaymentTransactionResult>? paymentTransactions;
  final PaginationInfo? paginationInfo;

  const PaymentTransactionsWithPagination(
      {this.paymentTransactions, this.paginationInfo});

  factory PaymentTransactionsWithPagination.fromJson(Map<String, dynamic> json) => _$PaymentTransactionsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.paymentTransactions, this.paginationInfo];

}