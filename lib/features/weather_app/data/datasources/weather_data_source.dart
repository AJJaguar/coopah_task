import 'package:coopah_task/features/weather_app/domain/repositories/weather_repository.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/weather_entity.dart';
import '../models/weather_model.dart';

abstract class WeatherDataSource {
  Future<WeatherEntity> getWeather(LocationCoordinates param);
}

class WeatherDataSourceImpl implements WeatherDataSource {
  WeatherDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<WeatherEntity> getWeather(LocationCoordinates param) async {
    // Obfuscate ApiKey

    String apiKey = 'd39d56c77e53ff78e679b0861e2b1daa';

    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=${param.lat}&lon=${param.long}&appid=$apiKey&units=metric',
    );

    final json = response.data;
    final weather = WeatherModel.fromMap(json);
    return weather;
  }
}
