import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final int? roleId;
  final String? mobileNumber;
  final bool? disabled;

  const User(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.roleId,
        this.mobileNumber,
        this.disabled});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.roleId,
    this.mobileNumber,
    this.disabled
  ];
}