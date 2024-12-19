import 'dart:convert'; // For JSON parsing
import 'package:http/http.dart' as http; // For network requests
import 'package:clima/services/location.dart';

const apiKey = 'ca0356f33508b162dc5d1658b45681cd';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  // Method to get weather icon based on condition
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  // Method to get weather message based on temperature
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  // Method to get weather for the city (by city name)
  Future<dynamic> getCityWeather(String cityName) async {
    // Construct the URL for the city weather API call
    final url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';

    try {
      // Make the API request
      final response = await http.get(Uri.parse(url));

      // If the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON data
        var weatherData = jsonDecode(response.body);
        return weatherData; // Return the weather data
      } else {
        throw 'Error: Unable to fetch weather data for $cityName';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }

  // Method to get weather for the user's current location (latitude and longitude)
  Future<dynamic> getLocationWeather() async {
    // Get the user's current location (latitude and longitude)
    Location location = Location();
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;

    final url =
        '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      // Make the API request
      final response = await http.get(Uri.parse(url));

      // If the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON data
        var weatherData = jsonDecode(response.body);
        return weatherData; // Return the weather data
      } else {
        throw 'Error: Unable to fetch weather data for location';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
