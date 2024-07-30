part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherEvent extends WeatherEvent {
  const GetWeatherEvent({required this.param});
  final LocationCoordinates param;

  @override
  List<Object?> get props => [param];
}

class ToggleTemperatureEvent extends WeatherEvent {
  const ToggleTemperatureEvent({
    required this.unit,
  });
  final TemperatureUnit unit;

  @override
  List<Object?> get props => [unit];
}
