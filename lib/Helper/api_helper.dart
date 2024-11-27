import 'dart:convert';

import 'package:weather_app/Models/weathers_model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Future<WeatherModel?> weatherApiHelper() async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=6aaa7a39609d43d680c71129242511&q=Surat");

    http.Response res = await http.get(url);

    if (res.statusCode == 200) {
      Map<String, dynamic> weather = jsonDecode(res.body);
      WeatherModel weatherData = WeatherModel.fromJson(weather);
      return weatherData;
    }
    return null;
  }
}
