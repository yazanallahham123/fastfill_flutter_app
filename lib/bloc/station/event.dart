import 'package:equatable/equatable.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';
import 'package:fastfill/model/syberPay/syber_pay_get_url_body.dart';

import '../../model/syberPay/syber_pay_check_status_body.dart';
import '../../model/syberPay/syber_pay_get_url_response_body.dart';
import '../../model/user/user_refill_transaction_dto.dart';

abstract class StationEvent extends Equatable{

  const StationEvent();

  @override
  List<Object?> get props => [];
}

class InitStationEvent extends StationEvent {
  const InitStationEvent();
}

class FrequentlyVisitedStationsBranchesEvent extends StationEvent{
  const FrequentlyVisitedStationsBranchesEvent();
}

class FavoriteStationsBranchesEvent extends StationEvent{
  const FavoriteStationsBranchesEvent();
}

class FrequentlyVisitedStationsEvent extends StationEvent{
  const FrequentlyVisitedStationsEvent();
}

class FavoriteStationsEvent extends StationEvent{
  const FavoriteStationsEvent();
}

class StationByTextEvent extends StationEvent{
  final String text;
  const StationByTextEvent(this.text);

  @override
  List<Object?> get props => [this.text];
}

class StationBranchByTextEvent extends StationEvent{
  final String text;
  const StationBranchByTextEvent(this.text);

  @override
  List<Object?> get props => [this.text];
}


class AddStationToFavoriteEvent extends StationEvent{
  final int stationId;
  const AddStationToFavoriteEvent(this.stationId);

  @override
  List<Object?> get props => [this.stationId];
}

class RemoveStationFromFavoriteEvent extends StationEvent{
  final int stationId;
  const RemoveStationFromFavoriteEvent(this.stationId);

  @override
  List<Object?> get props => [this.stationId];
}

class AddStationBranchToFavoriteEvent extends StationEvent{
  final int stationBranchId;
  const AddStationBranchToFavoriteEvent(this.stationBranchId);

  @override
  List<Object?> get props => [this.stationBranchId];
}

class RemoveStationBranchFromFavoriteEvent extends StationEvent{
  final int stationBranchId;
  const RemoveStationBranchFromFavoriteEvent(this.stationBranchId);

  @override
  List<Object?> get props => [this.stationBranchId];
}

class AllStationsBranchesEvent extends StationEvent{
  const AllStationsBranchesEvent();
}

class AllStationsEvent extends StationEvent{
  const AllStationsEvent();
}

class AddPaymentTransaction extends StationEvent{
  final PaymentTransactionBody paymentTransactionBody;
  const AddPaymentTransaction(this.paymentTransactionBody);

  @override
  List<Object?> get props => [this.paymentTransactionBody];
}

class GetPaymentTransactionsEvent extends StationEvent{
  final int page;

  const GetPaymentTransactionsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class Station_GetSyberPayUrlEvent extends StationEvent {
  final SyberPayGetUrlBody syberPayGetUrlBody;

  const Station_GetSyberPayUrlEvent(this.syberPayGetUrlBody);

  @override
  List<Object?> get props => [this.syberPayGetUrlBody];
}

class AddUserRefillTransactionEvent extends StationEvent {
  final UserRefillTransactionDto userRefillTransactionDto;
  final SyberPayGetUrlResponseBody syberPayGetUrlResponseBody;

  const AddUserRefillTransactionEvent(this.userRefillTransactionDto, this.syberPayGetUrlResponseBody);

  @override
  List<Object?> get props => [this.userRefillTransactionDto];
}

class GetUserBalanceInStationEvent extends StationEvent {
  const GetUserBalanceInStationEvent();
}

class ClearTransactionsEvent extends StationEvent {
  const ClearTransactionsEvent();
}


class CheckSyberStatusEvent extends StationEvent {
  final SyberPayCheckStatusBody syberPayCheckStatusBody;
  const CheckSyberStatusEvent(this.syberPayCheckStatusBody);

  @override
  List<Object?> get prop => [this.syberPayCheckStatusBody];
}

class GetFastFillFeesEvent extends StationEvent{
  const GetFastFillFeesEvent();
}

