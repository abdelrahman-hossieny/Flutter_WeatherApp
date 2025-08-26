class ForecastModel {
  final List<WeatherForecast> forecasts;

  ForecastModel({required this.forecasts});

  // For OpenWeatherMap API format
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<WeatherForecast> forecasts = list.map((i) => WeatherForecast.fromJson(i)).toList();

    return ForecastModel(forecasts: forecasts);
  }

  // For WeatherAPI.com format
  factory ForecastModel.fromWeatherApiJson(Map<String, dynamic> json) {
    var forecastDays = json['forecast']['forecastday'] as List;
    List<WeatherForecast> forecasts = [];

    for (var day in forecastDays) {
      var hourlyData = day['hour'] as List;
      for (var hour in hourlyData) {
        forecasts.add(WeatherForecast.fromWeatherApiJson(hour));
      }
    }

    return ForecastModel(forecasts: forecasts);
  }
}

class WeatherForecast {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String description;
  final String mainCondition;
  final String icon;
  final int humidity;

  WeatherForecast({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.description,
    required this.mainCondition,
    required this.icon,
    required this.humidity,
  });

  // For OpenWeatherMap API format
  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      tempMin: (json['main']['temp_min'] ?? 0).toDouble(),
      tempMax: (json['main']['temp_max'] ?? 0).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      mainCondition: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
    );
  }

  // For WeatherAPI.com format
  factory WeatherForecast.fromWeatherApiJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dateTime: DateTime.parse(json['time']),
      temperature: (json['temp_c'] ?? 0).toDouble(),
      tempMin: (json['temp_c'] ?? 0).toDouble(), // WeatherAPI doesn't provide min/max for hourly
      tempMax: (json['temp_c'] ?? 0).toDouble(),
      description: json['condition']['text'] ?? '',
      mainCondition: json['condition']['text'] ?? '',
      icon: json['condition']['icon'] ?? '',
      humidity: json['humidity'] ?? 0,
    );
  }
}