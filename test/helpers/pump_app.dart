import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    MockNavigator? navigator,
    WeatherRepository? weatherRepository,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: weatherRepository ?? MockWeatherRepository(),
        child: MaterialApp(
          home: navigator == null
              ? Scaffold(body: widgetUnderTest)
              : MockNavigatorProvider(
                  navigator: navigator,
                  child: Scaffold(
                    body: widgetUnderTest,
                  ),
                ),
        ),
      ),
    );
  }
}
