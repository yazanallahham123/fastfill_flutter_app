import 'package:equatable/equatable.dart';
import 'package:fastfill/model/common/pagination_info.dart';
import 'package:fastfill/model/station/station.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stations_with_pagination.g.dart';

@JsonSerializable()
class StationsWithPagination extends Equatable {
  final List<Station>? companies;
  final PaginationInfo? paginationInfo;

  const StationsWithPagination(
      {this.companies, this.paginationInfo});

  factory StationsWithPagination.fromJson(Map<String, dynamic> json) => _$StationsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$StationsWithPaginationToJson(this);

  @override
  List<Object?> get props =>
      [this.companies, this.paginationInfo];

}