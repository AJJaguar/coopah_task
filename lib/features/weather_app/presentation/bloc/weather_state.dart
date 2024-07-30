part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState({
    this.weather,
    required this.unit,
  });
  final WeatherEntity? weather;
  final TemperatureUnit unit;

  @override
  List<Object?> get props => [weather, unit];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading({super.weather, required super.unit});
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded({super.weather, required super.unit});
}

class WeatherEventFailed extends WeatherState {
  final Failure failure;
  const WeatherEventFailed({
    required this.failure,
    required super.unit,
  });
}
