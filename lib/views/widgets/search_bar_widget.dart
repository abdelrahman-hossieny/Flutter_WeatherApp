import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/weather_controller.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for a city...',
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.white70),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<WeatherController>().searchWeatherByCity(value);
          }
        },
      ),
    );
  }
}