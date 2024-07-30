import 'package:coopah_task/common/app_constants.dart';
import 'package:coopah_task/core/error/failure.dart';
import 'package:coopah_task/features/weather_app/domain/entities/weather_entity.dart';
import 'package:coopah_task/features/weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:coopah_task/features/weather_app/presentation/bloc/weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockGetWeatherEventUseCase extends Mock
    implements GetWeatherEventUseCase {}

class MockWeather extends Mock implements WeatherEntity {}

void main() {
  late WeatherBloc weatherBloc;
  late MockGetWeatherEventUseCase mockGetWeatherEventUseCase;

  setUp(() {
    mockGetWeatherEventUseCase = MockGetWeatherEventUseCase();
    weatherBloc = WeatherBloc(mockGetWeatherEventUseCase);
  });

  tearDown(() async {
    await weatherBloc.close();
  });

  group('WeatherBloc', () {
    test('initial state is WeatherLoading with TemperatureUnit.celsius', () {
      expect(weatherBloc.state,
          const WeatherLoading(unit: TemperatureUnit.celsius));
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when GetWeatherEvent is added and succeeds',
      build: () {
        final weather = MockWeather();
        when(() => mockGetWeatherEventUseCase(AppConstants.location))
            .thenAnswer(
          (_) async => Right(weather),
        );
        return weatherBloc;
      },
      act: (bloc) =>
          bloc.add(const GetWeatherEvent(param: AppConstants.location)),
      expect: () => [
        const WeatherLoading(unit: TemperatureUnit.celsius),
        isA<WeatherLoaded>(),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherEventFailed] when GetWeatherEvent is added and fails',
      build: () {
        when(() => mockGetWeatherEventUseCase(AppConstants.location))
            .thenAnswer(
          (_) async => const Left(
            WeatherFailure('message'),
          ),
        );
        return weatherBloc;
      },
      act: (bloc) =>
          bloc.add(const GetWeatherEvent(param: AppConstants.location)),
      expect: () => [
        const WeatherLoading(unit: TemperatureUnit.celsius),
        isA<WeatherEventFailed>(),
      ],
    );
  });
}
