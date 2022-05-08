// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_cards_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankCardsWithPagination _$BankCardsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    BankCardsWithPagination(
      bankCards: (json['bankCards'] as List<dynamic>?)
          ?.map((e) => BankCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BankCardsWithPaginationToJson(
        BankCardsWithPagination instance) =>
    <String, dynamic>{
      'bankCards': instance.bankCards,
      'paginationInfo': instance.paginationInfo,
    };
