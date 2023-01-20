import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class _MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {}

const settingsViewListViewKey = Key('settingsView_listView');
const settingsViewAppBarKey = Key('settingsView_appBar');
const settingsViewListTileKey = Key('settingsView_listTile');
const settingsViewSwitchKey = Key('settingsView_Switch');

void main() {
  late WeatherCubit _weatherCubit;

  setUp(
    () {
      initHydratedStorage();
      _weatherCubit = _MockWeatherCubit();

      when(() => _weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.initial,
        ),
      );
    },
  );

  group('renders', () {
    testWidgets('Settings AppBar', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: SettingsView(),
        ),
      );

      expect(
        find.byKey(settingsViewAppBarKey),
        findsOneWidget,
      );
    });

    testWidgets('Settings ListView', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: SettingsView(),
        ),
      );

      expect(
        find.byKey(settingsViewListViewKey),
        findsOneWidget,
      );
    });

    testWidgets('Settings ListTile', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: SettingsView(),
        ),
      );

      expect(
        find.byKey(settingsViewListTileKey),
        findsOneWidget,
      );
    });
  });

  group('adds', () {
    testWidgets('toggleUnits when switch', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: SettingsView(),
        ),
      );

      await tester.tap(find.byKey(settingsViewSwitchKey));
      await tester.pump();

      verify(() => _weatherCubit.toggleUnits()).called(1);
    });
  });
}
