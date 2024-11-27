import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Controllers/weather_controller.dart';
import 'package:weather_app/Views/SplashScreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherController(),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: Size(
          size.width,
          size.height,
        ),
        builder: (context, _) {
          return Flexify(
            designWidth: size.width,
            designHeight: size.height,
            app: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
