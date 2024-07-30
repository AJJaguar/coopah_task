import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/weather_entity.dart';

typedef LocationCoordinates = ({String lat, String long});

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(
    LocationCoordinates param,
  );
}
