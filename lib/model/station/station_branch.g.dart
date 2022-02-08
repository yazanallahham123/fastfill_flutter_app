// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationBranch _$StationBranchFromJson(Map<String, dynamic> json) =>
    StationBranch(
      id: json['id'] as int?,
      companyId: json['companyId'] as int?,
      arabicName: json['arabicName'] as String?,
      englishName: json['englishName'] as String?,
      code: json['code'] as String?,
      arabicAddress: json['arabicAddress'] as String?,
      englishAddress: json['englishAddress'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$StationBranchToJson(StationBranch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'arabicName': instance.arabicName,
      'englishName': instance.englishName,
      'code': instance.code,
      'arabicAddress': instance.arabicAddress,
      'englishAddress': instance.englishAddress,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'isFavorite': instance.isFavorite,
    };
