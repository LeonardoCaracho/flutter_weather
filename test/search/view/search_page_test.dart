import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/routes/routes_constants.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class _MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {}

void main() {
  late WeatherCubit _weatherCubit;
  late MockGoRouter _goRouter;

  group('SearchPage', () {
    setUpAll(() {
      _weatherCubit = _MockWeatherCubit();
      _goRouter = MockGoRouter();
    });
    testWidgets('should renders correct page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: _goRouter,
            child: BlocProvider.value(
              value: _weatherCubit,
              child: SearchPage(),
            ),
          ),
        ),
      );

      expect(find.byType(SearchPage), findsOneWidget);
      expect(find.text('City Search'), findsOneWidget);
    });

    testWidgets('should push when click in search', (tester) async {
      when(() => _weatherCubit.state).thenReturn(
        WeatherState(
          status: WeatherStatus.initial,
        ),
      );
      when(() => _weatherCubit.fetchWeather(any())).thenAnswer((_) async => {});

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: _goRouter,
            child: BlocProvider.value(
              value: _weatherCubit,
              child: SearchPage(),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(Key('searchPage_search_iconButton')));

      verify(() => _goRouter.go(Routes.home)).called(1);
    });
  });
}
