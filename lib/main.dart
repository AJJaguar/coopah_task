import 'package:coopah_task/common/app_constants.dart';
import 'package:coopah_task/di/locator.dart';
import 'package:coopah_task/features/weather_app/presentation/pages/weather_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/weather_app/domain/usecases/get_weather_usecase.dart';
import 'features/weather_app/presentation/bloc/weather_bloc.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
        locator<GetWeatherEventUseCase>(),
      )..add(
          const GetWeatherEvent(param: AppConstants.location),
        ),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0XFFFF5700),
          ),
          fontFamily: 'CircularStd',
          useMaterial3: true,
        ),
        home: const WeatherApp(),
      ),
    );
  }
}
