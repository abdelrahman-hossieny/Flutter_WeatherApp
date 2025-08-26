import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/location_model.dart';

class LocationController extends ChangeNotifier {
  LocationModel? _currentLocation;
  bool _isLoadingLocation = false;
  String? _locationError;

  // Getters
  LocationModel? get currentLocation => _currentLocation;
  bool get isLoadingLocation => _isLoadingLocation;
  String? get locationError => _locationError;

  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    _locationError = null;
    notifyListeners();

    try {
      // Check location permission
      final permission = await Permission.location.request();
      if (permission.isDenied) {
        _locationError = "Location permission denied";
        _isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationError = "Location services are disabled";
        _isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLocation = LocationModel.fromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        cityName: "Current Location", // You can use reverse geocoding to get city name
        country: "Unknown",
      );

      _isLoadingLocation = false;
      notifyListeners();
    } catch (e) {
      _locationError = "Failed to get location: ${e.toString()}";
      _isLoadingLocation = false;
      notifyListeners();
    }
  }

  void clearLocationError() {
    _locationError = null;
    notifyListeners();
  }
}