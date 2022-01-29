import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable()
class LoginBody extends Equatable {
  final String? password;
  final String? mobileNumber;

  const LoginBody({this.password, this.mobileNumber});

  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.password, this.mobileNumber];
}
