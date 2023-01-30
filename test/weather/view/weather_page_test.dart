import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

class _MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {}

void main() {
  late WeatherCubit weatherCubit;
  late MockGoRouter goRouter;

  setUp(() {
    initHydratedStorage();
    weatherCubit = _MockWeatherCubit();
    goRouter = MockGoRouter();
    when(() => weatherCubit.state).thenAnswer((invocation) => WeatherState(
          status: WeatherStatus.initial,
        ));
  });
  group('WeatherPage', () {
    testWidgets('renders WeatherPage', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: goRouter,
            child: BlocProvider.value(
              value: weatherCubit,
              child: const WeatherPage(),
            ),
          ),
        ),
      );

      expect(find.byType(WeatherPage), findsOneWidget);
    });
  });
}
