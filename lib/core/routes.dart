import 'package:flutter/material.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/forecast_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String forecast = '/forecast';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    forecast: (context) => ForecastScreen(),
  };
}