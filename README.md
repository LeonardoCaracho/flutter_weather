# Flutter Weather App

An example Flutter weather app using the [OpenMeteoApi API](https://open-meteo.com/).

<img src="https://github.com/leonardocaracho/flutter_weather/blob/main/.github/images/flutter_weather.gif?raw=true" alt="Flutter Weather App Preview" width=50% height=50%>

## Related Tutorials

- [Flutter Weather Tutorial](https://bloclibrary.dev/#/flutterweathertutorial)

## Supported Features

- [x] Current weather (condition and temperature)
- [x] switch temperature metric unit
- [x] Search by city

## App Architecture

The app is composed by four main layers.

### Data Layer

The data layer contains a single weather repository that is used to fetch weather raw data from the API.

### Repository

Abstract the data layer and expose domain models for the application to consume, facilitating the communication with the Bussiness Logic layer.

### Bussiness Logic

Consumes the domain model from the repository layer and expose a feature-level model which will be surfaced to the user via UI.

### Presentation Layer

This layer holds all the widgets, along with their blocs.
Widgets do not communicate directly with the repository.

## Packages in use

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) for state management
- [build_runner](https://pub.dev/packages/build_runner) for code generation
- [http](https://pub.dev/packages/http) for talking to the REST API
- [mocktail](https://pub.dev/packages/mocktail) for testing
- [go_router](https://pub.dev/packages/go_router) for navigation

## About the OpenMeteo weather API

The app shows data from the following endpoints:

- [Get location for a given city](https://open-meteo.com/en/docs/geocoding-api)
- [Get weather conditions](https://open-meteo.com/en/docs)

**Note**: to use the API you'll need to register an account and obtain your own API key.

### [LICENSE: MIT](LICENSE.md)