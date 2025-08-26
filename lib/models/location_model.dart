class LocationModel {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final String? condition;
  final double? tempInC;
  final String? cityName;
  final double? latitude;
  final double? longitude;

  LocationModel({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.condition,
    this.tempInC,
    this.cityName,
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['location']['name'] ?? '',
      country: json['location']['country'] ?? '',
      lat: (json['location']['lat'] ?? 0).toDouble(),
      lon: (json['location']['lon'] ?? 0).toDouble(),
      condition: json['current']?['condition']?['text'],
      tempInC: json['current']?['temp_c']?.toDouble(),
    );
  }

  // Alternative constructor for coordinate-based creation
  LocationModel.fromCoordinates({
    required double latitude,
    required double longitude,
    required String cityName,
    required String country,
    this.condition,
    this.tempInC,
  }) : name = cityName,
        lat = latitude,
        lon = longitude,
        cityName = cityName,
        latitude = latitude,
        longitude = longitude,
        country = country;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'lat': lat,
      'lon': lon,
      'condition': condition,
      'tempInC': tempInC,
    };
  }
}