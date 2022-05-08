import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'syber_pay_check_status_body.g.dart';

@JsonSerializable()
class SyberPayCheckStatusBody extends Equatable {
  final String? applicationId;
  final String? transactionId;
  final String? hash;

  const SyberPayCheckStatusBody(
      {this.applicationId,
        this.transactionId,
        this.hash});

  factory SyberPayCheckStatusBody.fromJson(Map<String, dynamic> json) => _$SyberPayCheckStatusBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SyberPayCheckStatusBodyToJson(this);

  @override
  List<Object?> get props => [
    this.applicationId,
    this.transactionId,
    this.hash
  ];
}