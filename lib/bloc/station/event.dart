import 'package:equatable/equatable.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';

abstract class StationEvent extends Equatable{

  const StationEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends StationEvent {
  const InitEvent();
}

class FrequentlyVisitedStationsEvent extends StationEvent{
  const FrequentlyVisitedStationsEvent();
}

class FavoriteStationsEvent extends StationEvent{
  const FavoriteStationsEvent();
}

class StationByNumberEvent extends StationEvent{
  final int number;
  const StationByNumberEvent(this.number);

  @override
  List<Object?> get props => [this.number];
}