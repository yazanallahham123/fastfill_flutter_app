import 'package:equatable/equatable.dart';
import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';
import 'package:fastfill/model/station/payment_transactions_with_pagination.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/station/station_branches_with_pagination.dart';

import '../../model/station/payment_transaction_result.dart';

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
  final StationBranchesWithPagination frequentlyVisitedStations;

  const GotFrequentlyVisitedStationsState(this.frequentlyVisitedStations);

  @override
  List<Object?> get props => [this.frequentlyVisitedStations];
}

class GotFavoriteStationsState extends StationState{
  final StationBranchesWithPagination favoriteStations;

  const GotFavoriteStationsState(this.favoriteStations);

  @override
  List<Object?> get props => [this.favoriteStations];
}

class GotStationByCodeState extends StationState{
  final StationBranch stationBranch;

  const GotStationByCodeState(this.stationBranch);

  @override
  List<Object?> get props => [this.stationBranch];
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

class GotStationBranchByCodeState extends StationState{
  final StationBranchesWithPagination stationsBranches;

  const GotStationBranchByCodeState(this.stationsBranches);

  @override
  List<Object?> get props => [this.stationsBranches];
}

class GotAllStationsBranchesState extends StationState{
  final StationBranchesWithPagination stationsBranches;

  const GotAllStationsBranchesState(this.stationsBranches);

  @override
  List<Object?> get props => [this.stationsBranches];
}

class AddingRemovingStationBranchToFavorite extends StationState{
  final int stationBranchId;

  const AddingRemovingStationBranchToFavorite(this.stationBranchId);

  @override
  List<Object?> get props => [this.stationBranchId];
}

class AddedPaymentTransaction extends StationState{
  final bool addPaymentTransactionResult;

  const AddedPaymentTransaction(this.addPaymentTransactionResult);

  @override
  List<Object?> get props => [this.addPaymentTransactionResult];
}

class GotPaymentTransactions extends StationState{
  final PaymentTransactionsWithPagination paymentTransactionsWithPagination;

  const GotPaymentTransactions(this.paymentTransactionsWithPagination);

  @override
  List<Object?> get props => [this.paymentTransactionsWithPagination];
}
