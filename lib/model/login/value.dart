import 'package:equatable/equatable.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'value.g.dart';

@JsonSerializable()
class Value extends Equatable {
  final String? token;
  final User? userDetails;

  const Value({this.token, this.userDetails});

  factory Value.fromJson(Map<String, dynamic> json) =>
      _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  @override
  List<Object?> get props => [this.token, this.userDetails];
}