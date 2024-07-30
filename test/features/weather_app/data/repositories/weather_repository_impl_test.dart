import 'package:coopah_task/core/error/failure.dart';
import 'package:coopah_task/features/weather_app/data/datasources/weather_data_source.dart';
import 'package:coopah_task/features/weather_app/data/repositories/weather_repository_impl.dart';
import 'package:coopah_task/features/weather_app/domain/entities/weather_entity.dart';
import 'package:coopah_task/features/weather_app/domain/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockWeatherDataSource extends Mock implements WeatherDataSource {}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherDataSource mockWeatherDataSource;

  setUp(() {
    mockWeatherDataSource = MockWeatherDataSource();
    repository = WeatherRepositoryImpl(mockWeatherDataSource);
  });

  group('WeatherRepositoryImpl', () {

    LocationCoordinates testLocation = (lat: '1.0', long: '1.0');
    const testWeatherEntity =  WeatherEntity(
      temperature: 20.0,
      location: 'Test Location',
    );

    test('should return weather data when the call to data source is successful', () async {
      // arrange
      when(() => mockWeatherDataSource.getWeather(testLocation))
          .thenAnswer((_) async => testWeatherEntity);

      // act
      final result = await repository.getWeather(testLocation);

      // assert
      expect(result, const Right(testWeatherEntity));
      verify(() => mockWeatherDataSource.getWeather(testLocation)).called(1);
    });

    test('should return a failure when the call to data source is unsuccessful', () async {
      // arrange
      when(() => mockWeatherDataSource.getWeather(testLocation)).thenThrow(Exception());

      // act
      final result = await repository.getWeather(testLocation);

      // assert
      expect(result, const Left(WeatherFailure('Failed to load data')));
      verify(() => mockWeatherDataSource.getWeather(testLocation)).called(1);
    });
  });
}
