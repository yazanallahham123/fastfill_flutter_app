// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transactions_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransactionsWithPagination _$PaymentTransactionsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    PaymentTransactionsWithPagination(
      paymentTransactions: (json['paymentTransactions'] as List<dynamic>?)
          ?.map((e) =>
              PaymentTransactionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentTransactionsWithPaginationToJson(
        PaymentTransactionsWithPagination instance) =>
    <String, dynamic>{
      'paymentTransactions': instance.paymentTransactions,
      'paginationInfo': instance.paginationInfo,
    };
