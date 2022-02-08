import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_branch.g.dart';

@JsonSerializable()
class StationBranch extends Equatable {
  final int? id;
  final int? companyId;
  final String? arabicName;
  final String? englishName;
  final String? code;
  final String? arabicAddress;
  final String? englishAddress;
  final double? longitude;
  final double? latitude;
  final bool? isFavorite;

  const StationBranch(
      {this.id,
        this.companyId,
        this.arabicName,
        this.englishName,
        this.code,
        this.arabicAddress,
        this.englishAddress,
        this.longitude,
        this.latitude,
        this.isFavorite});

  factory StationBranch.fromJson(Map<String, dynamic> json) => _$StationBranchFromJson(json);

  Map<String, dynamic> toJson() => _$StationBranchToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.companyId,
    this.arabicName,
    this.englishName,
    this.code,
    this.arabicAddress,
    this.englishAddress,
    this.longitude,
    this.latitude,
    this.isFavorite
  ];
}