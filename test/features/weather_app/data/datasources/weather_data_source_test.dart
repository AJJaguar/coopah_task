import 'package:coopah_task/features/weather_app/data/datasources/weather_data_source.dart';
import 'package:coopah_task/features/weather_app/data/models/weather_model.dart';
import 'package:coopah_task/features/weather_app/domain/repositories/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late WeatherDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = WeatherDataSourceImpl(dio: mockDio);
  });

  group('WeatherDataSourceImpl', () {
    LocationCoordinates testLocation = (lat: '1.0', long: '1.0');
    final testJsonResponse = {
      'main': {'temp': 20.0},
      'name': 'Test Location'
    };
    final testWeatherEntity = WeatherModel.fromMap(testJsonResponse);

    test('should return weather data when the call to Dio is successful',
        () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: testJsonResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final result = await dataSource.getWeather(testLocation);

      // Assert
      expect(result, testWeatherEntity);
      verify(() => mockDio.get(any())).called(1);
    });

    test('should throw an exception when the call to Dio is unsuccessful',
        () async {
      // Arrange
      when(() => mockDio.get(any()))
          .thenThrow(Exception('Failed to load data'));

      // Act
      final call = dataSource.getWeather(testLocation);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(() => mockDio.get(any())).called(1);
    });
  });
}
