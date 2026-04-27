class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      mainCondition: json['current']['condition']['text'],
    );
  }
}
