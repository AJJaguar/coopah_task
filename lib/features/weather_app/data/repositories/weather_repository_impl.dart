import 'package:coopah_task/core/error/failure.dart';
import 'package:coopah_task/features/weather_app/data/datasources/weather_data_source.dart';

import 'package:coopah_task/features/weather_app/domain/entities/weather_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this.dataSource);

  final WeatherDataSource dataSource;

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(
    LocationCoordinates param,
  ) async {
    try {
      final weather = await dataSource.getWeather(param);
      return Right(weather);
    } catch (e) {
      return const Left(WeatherFailure('Failed to load data'));
    }
  }
}
