import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:flutter_weather/settings/view/settings_page.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../helpers/helpers.dart';

class _MockWeatherCubit extends MockCubit<WeatherState> implements WeatherCubit {}

void main() {
  late WeatherCubit weatherCubit;

  setUp(() {
    initHydratedStorage();
    weatherCubit = _MockWeatherCubit();
    when(() => weatherCubit.state).thenAnswer((invocation) => WeatherState(
          status: WeatherStatus.initial,
        ));
  });
  group('Routes', () {
    testWidgets('renders WeatherPage', (tester) async {
      await tester.pumpRealRouterApp(
        '/',
        (child) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: weatherCubit),
          ],
          child: child,
        ),
      );

      expect(find.byType(WeatherPage), findsOneWidget);
    });

    testWidgets('renders SettingsPage', (tester) async {
      await tester.pumpRealRouterApp(
        '/settings',
        (child) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: weatherCubit),
          ],
          child: child,
        ),
      );

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('renders Search', (tester) async {
      await tester.pumpRealRouterApp(
        '/search',
        (child) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: weatherCubit),
          ],
          child: child,
        ),
      );

      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
