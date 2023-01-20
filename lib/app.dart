import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/search/view/search_page.dart';
import 'package:flutter_weather/settings/view/settings_page.dart';
import 'package:flutter_weather/theme/theme.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_repository/weather_repository.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const WeatherPage(),
      routes: [
        GoRoute(
          path: "search",
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: "settings",
          builder: (context, state) => const SettingsPage(),
        )
      ],
    ),
  ],
);

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required WeatherRepository weatherRepository}) : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ThemeCubit(),
      ),
      BlocProvider(
        create: (_) => WeatherCubit(_weatherRepository),
      ),
    ], child: WeatherAppView());
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp.router(
          routerConfig: _router,
          theme: ThemeData(
            primaryColor: color,
            textTheme: GoogleFonts.rajdhaniTextTheme(),
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme).apply(bodyColor: Colors.white).headline6,
            ),
          ),
        );
      },
    );
  }
}
