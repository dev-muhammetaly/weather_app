# Weather App

A small Flutter app that shows the current city, temperature and weather condition. It uses the device location to find a city, then requests current conditions from WeatherAPI.

## Run locally

You need Flutter, a WeatherAPI key and a device with location support. Set your own key in the `WeatherService` constructor in `lib/pages/weather_page.dart`, then run:

```sh
flutter pub get
flutter run
```

Allow location access when prompted. The app needs an internet connection.

## Current scope

This version shows current conditions, not a multi-day forecast or city-search interface. The location lookup can fall back to London when reverse geocoding fails.

Error feedback is still basic: a failed request can leave the loading indicator visible. The service currently uses an HTTP endpoint, which can cause problems on platforms that require HTTPS.

The request and location lookup are in `lib/service/weather_service.dart`.
