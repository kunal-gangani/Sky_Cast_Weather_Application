import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Models/weathers_model.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Future<WeatherModel?> weatherApiHelper({required String city}) async {
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=6aaa7a39609d43d680c71129242511&q=$city");

    http.Response res = await http.get(url);

    if (res.statusCode == 200) {
      Map<String, dynamic> weather = jsonDecode(res.body);
      WeatherModel weatherData = WeatherModel.fromJson(weather);
      return weatherData;
    }
    return null;
  }
}
