import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/weather_controller.dart';
import '../../controllers/location_controller.dart';
import '../widgets/weather_card.dart';
import '../widgets/search_bar_widget.dart';
import '../../utils/app_colors.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherController _weatherController;
  late LocationController _locationController;

  @override
  void initState() {
    super.initState();
    _weatherController = WeatherController();
    _locationController = LocationController();

    // Load real weather data instead of mock
    _weatherController.searchWeatherByCity('Giza');
    _locationController.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _weatherController),
        ChangeNotifierProvider.value(value: _locationController),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        appBar: AppBar(
          title: Text('Weather App', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () => _showSearchDialog(),
            ),
          ],
        ),
        body: Consumer<WeatherController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (controller.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.white, size: 64),
                    SizedBox(height: 16),
                    Text(
                      controller.errorMessage!,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => controller.loadMockWeatherData(),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (controller.currentWeather == null) {
              return Center(
                child: Text(
                  'No weather data available',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.searchWeatherByCity('Giza');
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SearchBarWidget(),
                    SizedBox(height: 20),
                    WeatherCard(weather: controller.currentWeather!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: _weatherController,
                              child: ForecastScreen(),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                      ),
                      child: Text('View 7-Day Forecast'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search City'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter city name',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _weatherController.searchWeatherByCity(value);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}