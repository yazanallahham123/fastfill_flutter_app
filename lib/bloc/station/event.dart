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

