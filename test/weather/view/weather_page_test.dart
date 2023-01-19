import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class _MockWeatherCubit extends MockCubit<WeatherState>
    implements WeatherCubit {}

void main() {
  late WeatherCubit _weatherCubit;

  setUp(() {
    initHydratedStorage();
    _weatherCubit = _MockWeatherCubit();
    when(() => _weatherCubit.state).thenAnswer((invocation) => WeatherState(
          status: WeatherStatus.initial,
        ));
  });
  group('WeatherPage', () {
    test('has a page', () {
      expect(WeatherPage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders WeatherPage', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: _weatherCubit,
          child: WeatherPage(),
        ),
      );
      expect(find.byType(WeatherPage), findsOneWidget);
    });
  });
}
