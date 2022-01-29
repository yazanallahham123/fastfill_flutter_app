import 'package:equatable/equatable.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/station/station_branches_with_pagination.dart';

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

class GotStationByNumberState extends StationState{
  final StationBranch stationBranch;

  const GotStationByNumberState(this.stationBranch);

  @override
  List<Object?> get props => [this.stationBranch];
}