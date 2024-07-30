import 'package:coopah_task/features/weather_app/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.temperature,
    required super.location,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) => WeatherModel(
        location: map['name'],
        temperature: map['main']['temp'],
      );
}
