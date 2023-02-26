import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_up_param.g.dart';

@JsonSerializable()
class TopUpParam extends Equatable {
  final String? paymentUrl;
  final String? transactionId;

  const TopUpParam(
      {this.paymentUrl,
        this.transactionId});

  factory TopUpParam.fromJson(Map<String, dynamic> json) => _$TopUpParamFromJson(json);

  Map<String, dynamic> toJson() => _$TopUpParamToJson(this);

  @override
  List<Object?> get props => [
    this.paymentUrl,
    this.transactionId
  ];
}