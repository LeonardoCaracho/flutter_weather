import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

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
  group('SettingsPage', () {
    testWidgets('should render', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: weatherCubit,
          child: const SettingsPage(),
        ),
      );

      expect(
        find.byType(SettingsPage),
        findsOneWidget,
      );
    });
  });
}
