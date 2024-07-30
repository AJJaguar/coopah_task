import 'package:equatable/equatable.dart';

enum TemperatureUnit {
  fahrenheit,
  celsius,
}

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.temperature,
    required this.location,
  });

  final num temperature;
  final String location;

  WeatherEntity convertTo(TemperatureUnit unit) {
    final conversion = unit == TemperatureUnit.fahrenheit
        ? (temperature * (9 / 5)) + 32
        : ((temperature - 32) * 5 / 9);
    return WeatherEntity(temperature: conversion, location: location);
  }

  @override
  String toString() => '{ temperature: $temperature,'
      'location: $location,}';

  @override
  List<Object?> get props => [
        temperature,
        location,
      ];
}
