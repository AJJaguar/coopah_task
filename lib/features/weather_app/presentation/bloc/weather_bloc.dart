import 'dart:async';
import 'package:coopah_task/core/error/failure.dart';
import 'package:coopah_task/features/weather_app/domain/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(
    this._getWeatherEventUseCase,
  ) : super(
          const WeatherLoading(unit: TemperatureUnit.celsius),
        ) {
    on<GetWeatherEvent>(_onGetWeatherEvent);
    on<ToggleTemperatureEvent>(_onToggleTemperatureEvent);
  }

  final GetWeatherEventUseCase _getWeatherEventUseCase;


// Triggers the action to get weather data from the datasource
  FutureOr<void> _onGetWeatherEvent(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading(unit: state.unit));
    await _getWeatherEventUseCase(event.param).then(
      (value) => value.fold(
          (failure) => emit(
                WeatherEventFailed(failure: failure, unit: state.unit),
              ), (weather) {
        final weatherInRightUnit = state.unit == TemperatureUnit.fahrenheit
            ? weather.convertTo(state.unit)
            : weather;
        final newState =
            WeatherLoaded(unit: state.unit, weather: weatherInRightUnit);
        emit(newState);
      }),
    );
  }


/// Toggles the temperature unit
  Future<void> _onToggleTemperatureEvent(
    ToggleTemperatureEvent event,
    Emitter<WeatherState> emit,
  ) async {
    if (state.unit == event.unit) emit(state);

    final weatherInNewUnit = state.weather?.convertTo(event.unit);
    final newState = WeatherLoaded(unit: event.unit, weather: weatherInNewUnit);
    emit(newState);
  }
}
