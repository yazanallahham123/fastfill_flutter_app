import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_remove_station_favorite_body.g.dart';

@JsonSerializable()
class AddRemoveStationFavoriteBody extends Equatable {
  final int? companyId;

  const AddRemoveStationFavoriteBody(
      {
        this.companyId});

  factory AddRemoveStationFavoriteBody.fromJson(Map<String, dynamic> json) => _$AddRemoveStationFavoriteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddRemoveStationFavoriteBodyToJson(this);

  @override
  List<Object?> get props => [
    this.companyId
  ];
}