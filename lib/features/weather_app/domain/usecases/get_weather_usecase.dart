

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/weather_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/weather_repository.dart';

class GetWeatherEventUseCase implements UseCase<WeatherEntity, LocationCoordinates> {
  GetWeatherEventUseCase(this.weatherRepository);
  final WeatherRepository weatherRepository;

  @override
  Future<Either<Failure, WeatherEntity>> call(LocationCoordinates param) {
    return weatherRepository.getWeather(param);
  }
}

