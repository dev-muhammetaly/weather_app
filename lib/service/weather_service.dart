import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherApp/models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'http://api.weatherapi.com/v1/current.json';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?key=$apiKey&q=$cityName'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    // convert the location into a list of placemark objects
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // extract the city name from the first placemark (if list is not empty)
      String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;

      return city ?? "London"; // Default to London if city is null
    } catch (e) {
      // geocoding can fail on some platforms or with no network
      return "London";
    }
  }
}
