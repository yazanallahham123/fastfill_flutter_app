// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_branches_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationBranchesWithPagination _$StationBranchesWithPaginationFromJson(
        Map<String, dynamic> json) =>
    StationBranchesWithPagination(
      companiesBranches: (json['companiesBranches'] as List<dynamic>?)
          ?.map((e) => StationBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StationBranchesWithPaginationToJson(
        StationBranchesWithPagination instance) =>
    <String, dynamic>{
      'companiesBranches': instance.companiesBranches,
      'paginationInfo': instance.paginationInfo,
    };
