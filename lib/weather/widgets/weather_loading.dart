import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('⛅', style: TextStyle(fontSize: 64)),
        Text(
          key: const Key('weather_weatherLoadingText'),
          'Loading Weather',
          style: theme.textTheme.headline5,
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
