import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_remove_station_branch_favorite_body.g.dart';

@JsonSerializable()
class AddRemoveStationBranchFavoriteBody extends Equatable {
  final int? companyBranchId;

  const AddRemoveStationBranchFavoriteBody(
      {
        this.companyBranchId});

  factory AddRemoveStationBranchFavoriteBody.fromJson(Map<String, dynamic> json) => _$AddRemoveStationBranchFavoriteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddRemoveStationBranchFavoriteBodyToJson(this);

  @override
  List<Object?> get props => [
    this.companyBranchId
  ];
}