import 'package:flutter_weather/routes.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/weather/view/view.dart';
import 'package:go_router/go_router.dart';

GoRouter router([String? initialLocation]) => GoRouter(
      routes: [
        GoRoute(
          path: initialLocation ?? Routes.home,
          builder: (context, state) => const WeatherPage(),
          routes: [
            GoRoute(
              path: Routes.search,
              builder: (context, state) => const SearchPage(),
            ),
            GoRoute(
              path: Routes.settings,
              builder: (context, state) => const SettingsPage(),
            )
          ],
        ),
      ],
    );