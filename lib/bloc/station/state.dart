import 'package:equatable/equatable.dart';
import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';
import 'package:fastfill/model/station/payment_transactions_with_pagination.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/station/station_branches_with_pagination.dart';

import '../../model/station/payment_transaction_result.dart';
import '../../model/station/station.dart';
import '../../model/station/stations_with_pagination.dart';
import '../../model/syberPay/syber_pay_get_url_response_body.dart';

abstract class StationState extends Equatable{

  const StationState();

  @override
  List<Object?> get props => [];
}

class InitStationState extends StationState{
  const InitStationState();
}

class LoadingStationState extends StationState{
  const LoadingStationState();
}

class LoadingFavoriteStationState extends StationState{
  const LoadingFavoriteStationState();
}


class ErrorStationState extends StationState{
  final String error;

  const ErrorStationState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class GotFrequentlyVisitedStationsState extends StationState{
  final StationsWithPagination frequentlyVisitedStations;

  const GotFrequentlyVisitedStationsState(this.frequentlyVisitedStations);

  @override
  List<Object?> get props => [this.frequentlyVisitedStations];
}

class GotFavoriteStationsState extends StationState{
  final StationsWithPagination favoriteStations;

  const GotFavoriteStationsState(this.favoriteStations);

  @override
  List<Object?> get props => [this.favoriteStations];
}

class GotStationsByTextState extends StationState{
  final StationsWithPagination stations;

  const GotStationsByTextState(this.stations);

  @override
  List<Object?> get props => [this.stations];
}


class AddedStationToFavorite extends StationState{
  final int stationId;

  const AddedStationToFavorite(this.stationId);

  @override
  List<Object?> get props => [this.stationId];
}

class RemovedStationFromFavorite extends StationState{
  final int stationId;

  const RemovedStationFromFavorite(this.stationId);

  @override
  List<Object?> get props => [this.stationId];
}


class AddedStationBranchToFavorite extends StationState{
  final int stationBranchId;

  const AddedStationBranchToFavorite(this.stationBranchId);

  @override
  List<Object?> get props => [this.stationBranchId];
}

class RemovedStationBranchFromFavorite extends StationState{
  final int stationBranchId;

  const RemovedStationBranchFromFavorite(this.stationBranchId);

  @override
  List<Object?> get props => [this.stationBranchId];
}

class GotFrequentlyVisitedStationsBranchesState extends StationState{
  final StationBranchesWithPagination frequentlyVisitedStationsBranches;

  const GotFrequentlyVisitedStationsBranchesState(this.frequentlyVisitedStationsBranches);

  @override
  List<Object?> get props => [this.frequentlyVisitedStationsBranches];
}

class GotFavoriteStationsBranchesState extends StationState{
  final StationBranchesWithPagination favoriteStationsBranches;

  const GotFavoriteStationsBranchesState(this.favoriteStationsBranches);

  @override
  List<Object?> get props => [this.favoriteStationsBranches];
}

class GotStationBranchByTextState extends StationState{
  final StationBranchesWithPagination stationsBranches;

  const GotStationBranchByTextState(this.stationsBranches);

  @override
  List<Object?> get props => [this.stationsBranches];
}

class GotAllStationsBranchesState extends StationState{
  final StationBranchesWithPagination stationsBranches;

  const GotAllStationsBranchesState(this.stationsBranches);

  @override
  List<Object?> get props => [this.stationsBranches];
}

class GotAllStationsState extends StationState{
  final StationsWithPagination stations;

  const GotAllStationsState(this.stations);

  @override
  List<Object?> get props => [this.stations];
}

class AddingRemovingStationBranchToFavorite extends StationState{
  final int stationBranchId;

  const AddingRemovingStationBranchToFavorite(this.stationBranchId);

  @override
  List<Object?> get props => [this.stationBranchId];
}


class AddingRemovingStationToFavorite extends StationState{
  final int stationId;

  const AddingRemovingStationToFavorite(this.stationId);

  @override
  List<Object?> get props => [this.stationId];
}

class AddedPaymentTransaction extends StationState{
  final bool addPaymentTransactionResult;
  final bool balanceNotEnough;

  const AddedPaymentTransaction(this.addPaymentTransactionResult, this.balanceNotEnough);

  @override
  List<Object?> get props => [this.addPaymentTransactionResult, this.balanceNotEnough];
}

class GotPaymentTransactionsState extends StationState{
  final PaymentTransactionsWithPagination paymentTransactionsWithPagination;

  const GotPaymentTransactionsState(this.paymentTransactionsWithPagination);

  @override
  List<Object?> get props => [this.paymentTransactionsWithPagination];
}

class Station_GotSyberPayUrlState extends StationState{
  final SyberPayGetUrlResponseBody syberPayGetUrlResponseBody;

  const Station_GotSyberPayUrlState(this.syberPayGetUrlResponseBody);

  @override
  List<Object?> get props => [this.syberPayGetUrlResponseBody];
}


class AddedUserRefillTransactionState extends StationState{
  final bool result;
  final SyberPayGetUrlResponseBody syberPayGetUrlResponseBody;

  const AddedUserRefillTransactionState(this.result, this.syberPayGetUrlResponseBody);

  @override
  List<Object?> get props => [this.result, this.syberPayGetUrlResponseBody];
}

class GotUserBalanceInStationState extends StationState{
  final double balance;

  const GotUserBalanceInStationState(this.balance);

  @override
  List<Object?> get props => [this.balance];
}
