import 'package:flutter/material.dart';
import 'package:weather_app/Helper/api_helper.dart';
import 'package:weather_app/Models/weathers_model.dart';

class WeatherController extends ChangeNotifier {
  WeatherModel? weather;
  String city = "";

  WeatherController() {
    fetchWeatherData();
  }
  Future<WeatherModel> fetchWeatherData() async {
    weather = await ApiHelper.apiHelper.weatherApiHelper();
    notifyListeners();
    return weather!;
  }
}
