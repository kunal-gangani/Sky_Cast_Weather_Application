import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/MyApp/my_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
  ));
  runApp(
    const MyApp(),
  );
}
