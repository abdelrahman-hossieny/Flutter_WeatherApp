import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';

class WeatherController extends ChangeNotifier {
  WeatherModel? _currentWeather;
  ForecastModel? _forecast;
  bool _isLoading = false;
  String? _errorMessage;
  final WeatherService _weatherService = WeatherService();

  // Getters
  WeatherModel? get currentWeather => _currentWeather;
  ForecastModel? get forecast => _forecast;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load weather data by coordinates
  Future<void> loadWeatherByCoordinates(double latitude, double longitude) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.getCurrentWeatherByCoordinates(latitude, longitude);
      _forecast = await _weatherService.getForecastByCoordinates(latitude, longitude);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _currentWeather = null;
      _forecast = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search weather by city name
  Future<void> searchWeatherByCity(String cityName) async {
    if (cityName.trim().isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.getCurrentWeather(cityName.trim());
      _forecast = await _weatherService.getForecast(cityName.trim());
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _currentWeather = null;
      _forecast = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mock data for development/testing
  void loadMockWeatherData() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulate API delay
    Future.delayed(const Duration(seconds: 2), () {
      _currentWeather = WeatherModel(
        cityName: "New York",
        country: "US",
        temperature: 22.5,
        description: "Clear sky",
        condition: "Clear",
        mainCondition: "Clear",
        feelsLike: 25.0,
        humidity: 65,
        windSpeed: 5.2,
        pressure: 1013,
        visibility: 10000,
        icon: "01d",
        dateTime: DateTime.now(),
      );

      _forecast = ForecastModel(
        forecasts: [
          WeatherForecast(
            dateTime: DateTime.now().add(const Duration(hours: 3)),
            temperature: 20.0,
            tempMin: 18.0,
            tempMax: 22.0,
            description: "Partly cloudy",
            mainCondition: "Clouds",
            icon: "02d",
            humidity: 70,
          ),
          WeatherForecast(
            dateTime: DateTime.now().add(const Duration(hours: 6)),
            temperature: 18.5,
            tempMin: 16.0,
            tempMax: 20.0,
            description: "Overcast",
            mainCondition: "Clouds",
            icon: "04d",
            humidity: 75,
          ),
        ],
      );

      _isLoading = false;
      notifyListeners();
    });
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearWeatherData() {
    _currentWeather = null;
    _forecast = null;
    _errorMessage = null;
    notifyListeners();
  }
}