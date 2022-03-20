import 'package:equatable/equatable.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';

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

class GetPaymentTransactions extends StationEvent{
  const GetPaymentTransactions();
}


