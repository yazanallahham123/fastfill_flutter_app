// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationBranch _$StationBranchFromJson(Map<String, dynamic> json) =>
    StationBranch(
      id: json['id'] as int?,
      companyId: json['companyId'] as int?,
      companyName: json['companyName'] as String?,
      name: json['name'] as String?,
      number: json['number'] as String?,
      address: json['address'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationBranchToJson(StationBranch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'name': instance.name,
      'number': instance.number,
      'address': instance.address,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
