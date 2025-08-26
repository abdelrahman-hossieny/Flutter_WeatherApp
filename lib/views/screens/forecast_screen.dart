import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/weather_controller.dart';
import '../widgets/forecast_item.dart';
import '../../utils/app_colors.dart';

class ForecastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      appBar: AppBar(
        title: Text('7-Day Forecast', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<WeatherController>(
        builder: (context, controller, child) {
          if (controller.forecast == null) {
            return Center(
              child: Text(
                'No forecast data available',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.forecast!.forecasts.length,
            itemBuilder: (context, index) {
              return ForecastItem(
                forecast: controller.forecast!.forecasts[index],
              );
            },
          );
        },
      ),
    );
  }
}