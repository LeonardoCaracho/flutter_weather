import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather/view/view.dart';
import 'package:flutter_weather/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>.value(
      value: context.read<WeatherCubit>(),
      child: const WeatherView(),
    );
  }
}
