import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_branch.g.dart';

@JsonSerializable()
class StationBranch extends Equatable {
  final int? id;
  final int? companyId;
  final String? companyName;
  final String? name;
  final String? number;
  final String? address;
  final double? longitude;
  final double? latitude;

  const StationBranch(
      {this.id,
        this.companyId,
        this.companyName,
        this.name,
        this.number,
        this.address,
        this.longitude,
        this.latitude});

  factory StationBranch.fromJson(Map<String, dynamic> json) => _$StationBranchFromJson(json);

  Map<String, dynamic> toJson() => _$StationBranchToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.companyId,
    this.companyName,
    this.name,
    this.number,
    this.address,
    this.longitude,
    this.latitude
  ];
}