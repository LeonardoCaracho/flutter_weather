import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/routes.dart';
import 'package:flutter_weather/theme/theme.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:go_router/go_router.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            key: Key('weather_settingsIconButton'),
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go(Routes.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty(
                  key: Key('weather_weatherEmptyWidget'),
                );
              case WeatherStatus.loading:
                return const WeatherLoading(
                  key: Key('weather_weatherLoadingWidget'),
                );
              case WeatherStatus.success:
                return WeatherPopulated(
                  key: Key('weather_weatherPopulatedWidget'),
                  weather: state.weather,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                );
              case WeatherStatus.failure:
                return const WeatherError(
                  key: Key('weather_weatherErrorWidget'),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('weather_searchFloatingActionButton'),
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          context.go(Routes.search);
        },
      ),
    );
  }
}
