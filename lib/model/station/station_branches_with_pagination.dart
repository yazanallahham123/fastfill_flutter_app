import 'package:equatable/equatable.dart';
import 'package:fastfill/model/common/pagination_info.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_branches_with_pagination.g.dart';

@JsonSerializable()
class StationBranchesWithPagination extends Equatable {
  final List<StationBranch>? companiesBranches;
  final PaginationInfo? paginationInfo;

  const StationBranchesWithPagination(
      {this.companiesBranches, this.paginationInfo});

  factory StationBranchesWithPagination.fromJson(Map<String, dynamic> json) => _$StationBranchesWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$StationBranchesWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.companiesBranches, this.paginationInfo];

}