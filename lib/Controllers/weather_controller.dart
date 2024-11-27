import 'package:flutter/material.dart';
import 'package:weather_app/Helper/api_helper.dart';
import 'package:weather_app/Models/weathers_model.dart';

class WeatherController extends ChangeNotifier {
  WeatherModel? weather;

  WeatherController() {
    fetchWeatherData();
  }
  void fetchWeatherData() async {
    weather = await ApiHelper.apiHelper.weatherApiHelper();
    notifyListeners();
  }
}
