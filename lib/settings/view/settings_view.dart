import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/weather/weather.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('settingsView_appBar'),
        title: const Text('Settings'),
      ),
      body: ListView(
        key: Key('settingsView_listView'),
        children: <Widget>[
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return ListTile(
                key: Key('settingsView_listTile'),
                title: const Text('Temperature Units'),
                isThreeLine: true,
                subtitle: const Text(
                  'Use metric measurements for temperature units.',
                ),
                trailing: Switch(
                  key: Key('settingsView_Switch'),
                  value: state.temperatureUnits.isCelsius,
                  onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
