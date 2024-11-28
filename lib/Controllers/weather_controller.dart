import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/Helper/api_helper.dart';
import 'package:weather_app/Models/weathers_model.dart';

class WeatherController extends ChangeNotifier {
  WeatherModel? weather;
  String city = "";

  Future<WeatherModel?> fetchWeatherData() async {
    log("WEATHER METHOD IS CALLED....");
    weather = await ApiHelper.apiHelper.weatherApiHelper();

    log("DATA : ${weather?.location.name}");
    return weather;
  }
}
