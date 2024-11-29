import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/Helper/api_helper.dart';
import 'package:weather_app/Models/weathers_model.dart';

class WeatherController extends ChangeNotifier {
  WeatherModel? weather;
  String city = "Surat";

  Future<WeatherModel?> fetchWeatherData() async {
    log("WEATHER METHOD IS CALLED....");
    if (city.isNotEmpty) {
      weather = await ApiHelper.apiHelper.weatherApiHelper(city: city);
      notifyListeners();
    }
    return weather;
  }

  void searchCity({required String search}) {
    city = search;
    notifyListeners();
  }

  void reloadCity() {
    city = "Surat";
    notifyListeners();
  }
}
