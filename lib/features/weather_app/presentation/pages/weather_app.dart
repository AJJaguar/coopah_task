import 'package:coopah_task/common/app_constants.dart';
import 'package:coopah_task/common/app_text_styles.dart';
import 'package:coopah_task/features/weather_app/domain/entities/weather_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  createState() => _WeatherPage();
}

class _WeatherPage extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0XFFF6F6F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => AspectRatio(
                    aspectRatio: constraints.maxWidth < 300 ? 4 / 3 : 16 / 9,
                    child: Image.asset('assets/images/sun.png'),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              BlocConsumer<WeatherBloc, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherEventFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.failure.message),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'THIS IS MY WEATHER APP',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'FuturaCondensed',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Temperature',
                            style: AppTextStyle.headline1(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${state.weather!.temperature.toStringAsFixed(2)} degrees',
                            style: AppTextStyle.headline2(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Location',
                            style: AppTextStyle.headline1(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.weather!.location,
                            style: AppTextStyle.headline2(),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Celsius/Fahrenheit',
                                style: AppTextStyle.headline2(),
                              ),
                              const SizedBox(width: 8),
                              CupertinoSwitch(
                                value: state.unit == TemperatureUnit.fahrenheit,
                                onChanged: (value) =>
                                    context.read<WeatherBloc>().add(
                                          ToggleTemperatureEvent(
                                            unit: value
                                                ? TemperatureUnit.fahrenheit
                                                : TemperatureUnit.celsius,
                                          ),
                                        ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 34),
        child: InkWell(
          onTap: () => context.read<WeatherBloc>().add(
                const GetWeatherEvent(param: (AppConstants.location)),
              ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0XFFFF5700),
            ),
            padding: const EdgeInsets.all(14),
            child: Text(
              'Refresh',
              textAlign: TextAlign.center,
              style: AppTextStyle.headline3(color: const Color(0XFFFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }
}
