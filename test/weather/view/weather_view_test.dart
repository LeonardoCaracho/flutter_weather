import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/theme/theme.dart';
import 'package:flutter_weather/weather/view/weather_view.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class _MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {}

class _MockThemeCubit extends MockCubit<Color> implements ThemeCubit {}

const weatherViewSettingsButtonKey = Key('weather_settingsIconButton');
const weatherViewSearchFloatingActionButtonKey = Key('weather_searchFloatingActionButton');
const weatherViewEmptyWidgetKey = Key('weather_weatherEmptyWidget');
const weatherViewLoadingWidgetKey = Key('weather_weatherLoadingWidget');
const weatherViewPopulatedWidgetKey = Key('weather_weatherPopulatedWidget');
const weatherViewErrorWidgetKey = Key('weather_weatherErrorWidget');
const weatherViewEmojiText = Key('weather_emojiText');

void main() {
  late WeatherCubit _weatherCubit;
  late ThemeCubit _themeCubit;
  late MockNavigator _navigator;

  setUp(
    () {
      initHydratedStorage();
      _weatherCubit = _MockWeatherCubit();
      _themeCubit = _MockThemeCubit();
      _navigator = MockNavigator();

      when(() => _weatherCubit.state).thenAnswer(
        (invocation) => WeatherState(
          status: WeatherStatus.initial,
        ),
      );
    },
  );

  group('renders', () {
    testWidgets('Settings icon button', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      expect(
        find.byKey(weatherViewSettingsButtonKey),
        findsOneWidget,
      );
    });

    testWidgets('Search floating action button', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      expect(
        find.byKey(weatherViewSearchFloatingActionButtonKey),
        findsOneWidget,
      );
    });

    testWidgets('WeatherEmpty widget when initial', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      expect(
        find.byKey(weatherViewEmptyWidgetKey),
        findsOneWidget,
      );
    });

    testWidgets('WeatherLoading widget when loading', (tester) async {
      when(() => _weatherCubit.state).thenAnswer(
        (invocation) => WeatherState(
          status: WeatherStatus.loading,
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      expect(
        find.byKey(weatherViewLoadingWidgetKey),
        findsOneWidget,
      );
    });

    testWidgets('WeatherPopulated widget when success', (tester) async {
      when(() => _weatherCubit.state).thenAnswer(
        (invocation) => WeatherState(
          status: WeatherStatus.success,
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      expect(
        find.byKey(weatherViewPopulatedWidgetKey),
        findsOneWidget,
      );
    });

    testWidgets('WeatherError widget when fails', (tester) async {
      when(() => _weatherCubit.state).thenAnswer(
        (invocation) => WeatherState(
          status: WeatherStatus.failure,
        ),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      expect(
        find.byKey(weatherViewErrorWidgetKey),
        findsOneWidget,
      );
    });
  });

  group('adds', () {
    testWidgets('updateTheme when status is success', (tester) async {
      whenListen(
        _weatherCubit,
        Stream.fromIterable(
          [WeatherState(status: WeatherStatus.success)],
        ),
      );

      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _weatherCubit,
            ),
            BlocProvider.value(
              value: _themeCubit,
            )
          ],
          child: WeatherView(),
        ),
      );

      verify(() => _themeCubit.updateTheme(any())).called(1);
    });

    testWidgets('refreshWeather when refresh page', (tester) async {
      when(() => _weatherCubit.state).thenAnswer(
        (invocation) => WeatherState(
          status: WeatherStatus.success,
        ),
      );
      when(() => _weatherCubit.refreshWeather()).thenAnswer(
        (_) => Future.value(),
      );

      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
      );

      await tester.fling(find.byKey(weatherViewEmojiText), const Offset(0.0, 300.0), 1000.0);
      await tester.pump();

      expect(
          tester.getSemantics(find.byType(RefreshProgressIndicator)),
          matchesSemantics(
            label: 'Refresh',
          ));

      await tester.pump(
        const Duration(seconds: 1),
      ); // finish the scroll animation
      await tester.pump(
        const Duration(seconds: 1),
      ); // finish the indicator settle animation
      await tester.pump(
        const Duration(seconds: 1),
      ); // finish the indicator hide animation

      verify(() => _weatherCubit.refreshWeather()).called(1);

      handle.dispose();
    });

    testWidgets('fetchWeather when search', (tester) async {
      when(() => _navigator.push<String>(any())).thenAnswer((invocation) async => 'city');
      when(() => _weatherCubit.fetchWeather(any())).thenAnswer(
        (_) => Future.value(),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
        navigator: _navigator,
      );

      await tester.tap(find.byKey(weatherViewSearchFloatingActionButtonKey));

      verify(() => _weatherCubit.fetchWeather('city')).called(1);
    });
  });

  group('navigates', () {
    testWidgets('to SettingsPage when settings is clicked', (tester) async {
      when(() => _navigator.push<void>(any())).thenAnswer((invocation) async {});

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
        navigator: _navigator,
      );

      await tester.tap(find.byKey(weatherViewSettingsButtonKey));

      verify(() => _navigator.push<void>(any())).called(1);
    });

    testWidgets('to SearchPage search is clicked', (tester) async {
      when(() => _navigator.push<String>(any())).thenAnswer((invocation) async => 'city');
      when(() => _weatherCubit.fetchWeather(any())).thenAnswer(
        (_) => Future.value(),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherView(),
        ),
        navigator: _navigator,
      );

      await tester.tap(find.byKey(weatherViewSearchFloatingActionButtonKey));

      verify(() => _navigator.push<String>(any())).called(1);
    });
  });
}
