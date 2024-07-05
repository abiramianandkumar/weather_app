import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class WeatherProvider with ChangeNotifier {
  // WeatherFactory instance initialized with API key
  final WeatherFactory _weatherFactory = WeatherFactory(api);

  Weather? _weather;
  // Flag to indicate if data is currently being fetched
  bool _isLoading = false;

  // Getter to access current weather data and loading state
  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  //Fetches weather data for the given city name
  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherFactory.currentWeatherByCityName(cityName);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
