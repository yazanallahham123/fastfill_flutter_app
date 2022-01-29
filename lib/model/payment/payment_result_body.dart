import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_result_body.g.dart';

@JsonSerializable()
class PaymentResultBody extends Equatable {
  final String date;
  final String stationName;
  final String fuelType;
  final double amount;
  final double value;
  final bool status;

  const PaymentResultBody({
    required this.date,
    required this.stationName,
    required this.fuelType,
    required this.amount,
    required this.value,
    required this.status
  });

  factory PaymentResultBody.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResultBodyToJson(this);

  @override
  List<Object?> get props =>
      [  this.date,
         this.stationName,
         this.fuelType,
         this.amount,
         this.value,
         this.status];
}
