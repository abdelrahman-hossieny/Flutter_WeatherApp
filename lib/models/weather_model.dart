class WeatherModel {
  // attributes
  final String cityName;
  final String country;
  final double temperature;
  final String description;
  final String condition;
  final String? mainCondition;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double pressure;
  final double visibility;
  final String icon;
  final DateTime dateTime;
  final double? lat;
  final double? lon;
  // ctor
  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.description,
    required this.condition,
    this.mainCondition,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.icon,
    required this.dateTime,
    this.lat,
    this.lon,
  });
  // Handle data which got from API
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    final current = json['current'];

    return WeatherModel(
      cityName: location['name'] ?? '',
      country: location['country'] ?? '',
      lat: (location['lat'] ?? 0).toDouble(),
      lon: (location['lon'] ?? 0).toDouble(),
      temperature: (current['temp_c'] ?? 0).toDouble(),
      description: current['condition']['text'] ?? '',
      condition: current['condition']['text'] ?? '',
      mainCondition: current['condition']['text'] ?? '',
      feelsLike: (current['feelslike_c'] ?? 0).toDouble(),
      humidity: current['humidity'] ?? 0,
      windSpeed: (current['wind_kph'] ?? 0).toDouble(),
      pressure: (current['pressure_mb'] ?? 0).toDouble(),
      visibility: (current['vis_km'] ?? 0).toDouble(),
      icon: current['condition']['icon'] ?? '',
      dateTime: DateTime.tryParse(current['last_updated'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'country': country,
      'temperature': temperature,
      'description': description,
      'condition': condition,
      'mainCondition': mainCondition,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'pressure': pressure,
      'visibility': visibility,
      'icon': icon,
      'dateTime': dateTime.toIso8601String(),
      'lat': lat,
      'lon': lon,
    };
  }
}