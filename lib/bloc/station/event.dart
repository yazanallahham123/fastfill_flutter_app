import 'package:equatable/equatable.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';

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

class StationByCodeEvent extends StationEvent{
  final String code;
  const StationByCodeEvent(this.code);

  @override
  List<Object?> get props => [this.code];
}

class StationBranchByCodeEvent extends StationEvent{
  final String code;
  const StationBranchByCodeEvent(this.code);

  @override
  List<Object?> get props => [this.code];
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


