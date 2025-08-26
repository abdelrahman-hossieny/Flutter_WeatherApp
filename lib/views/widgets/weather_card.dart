import 'package:flutter/material.dart';
import '../../models/weather_model.dart';
import 'temperature_display.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            '${weather.cityName}, ${weather.country}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          TemperatureDisplay(temperature: weather.temperature),
          SizedBox(height: 10),
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherInfo('Feels like', '${weather.feelsLike.round()}°'),
              _buildWeatherInfo('Humidity', '${weather.humidity}%'),
              _buildWeatherInfo('Wind', '${weather.windSpeed} m/s'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}