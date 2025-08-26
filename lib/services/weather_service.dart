import 'package:dio/dio.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/location_model.dart';
import '../utils/constants.dart';

class WeatherService {
  final Dio _dio = Dio();

  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/current.json',
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': cityName,
          'aqi': 'no',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('City not found');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key');
      } else if (e.response?.statusCode == 403) {
        throw Exception('API key exceeded quota');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<WeatherModel> getCurrentWeatherByCoordinates(double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/current.json',
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': '$latitude,$longitude',
          'aqi': 'no',
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<ForecastModel> getForecast(String cityName) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/forecast.json',
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': cityName,
          'days': '7',
          'aqi': 'no',
        },
      );

      if (response.statusCode == 200) {
        return ForecastModel.fromWeatherApiJson(response.data);
      } else {
        throw Exception('Failed to fetch forecast data');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<ForecastModel> getForecastByCoordinates(double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/forecast.json',
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': '$latitude,$longitude',
          'days': '7',
          'aqi': 'no',
        },
      );

      if (response.statusCode == 200) {
        return ForecastModel.fromWeatherApiJson(response.data);
      } else {
        throw Exception('Failed to fetch forecast data');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<LocationModel> getLocationWeather(String cityName) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/current.json',
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': cityName,
          'aqi': 'no',
        },
      );

      if (response.statusCode == 200) {
        return LocationModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch location data');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}