import 'package:coopah_task/features/weather_app/data/repositories/weather_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/weather_app/data/datasources/weather_data_source.dart';
import '../features/weather_app/domain/repositories/weather_repository.dart';
import '../features/weather_app/domain/usecases/get_weather_usecase.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerFactory(() => GetWeatherEventUseCase(locator()))
    ..registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(
        locator(),
      ),
    )
    ..registerFactory<WeatherDataSource>(
      () => WeatherDataSourceImpl(dio: Dio()),
    );
}
