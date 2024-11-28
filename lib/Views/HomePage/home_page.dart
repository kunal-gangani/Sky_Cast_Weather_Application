import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Controllers/weather_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/Models/weathers_model.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4A90E2),
                Color(0xFF005C97),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Consumer<WeatherController>(
                  builder: (context, value, _) {
                    return FutureBuilder(
                      future: value.fetchWeatherData(),
                      builder: (context, snapShot) {
                        log("Data : ${snapShot.hasData}");
                        log("ERROR : ${snapShot.hasError}");
                        if (snapShot.hasError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.redAccent,
                                    size: 80.0,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    "Oops! Something went wrong.",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Text(
                                    "We couldn't fetch the weather data. Please try again later.",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      value.fetchWeatherData();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 12.0,
                                      ),
                                    ),
                                    child: const Text(
                                      "Retry",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (snapShot.hasData) {
                          WeatherModel? data = snapShot.data;
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          hintText: 'Search for a city',
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.2),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Search",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              if (data != null) ...[
                                Column(
                                  children: [
                                    Text(
                                      "${data.location.name},",
                                      style: TextStyle(
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      data.location.region,
                                      style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    // Local Time
                                    Text(
                                      data.location.localtime,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                    Icon(
                                      data.current.condition.text
                                              .toLowerCase()
                                              .contains("sunny")
                                          ? Icons.sunny
                                          : Icons.cloud,
                                      color: data.current.condition.text
                                              .toLowerCase()
                                              .contains("sunny")
                                          ? Colors.yellow
                                          : Colors.white,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    // Temperature
                                    Text(
                                      '${data.current.tempC}°C',
                                      style: TextStyle(
                                        fontSize: 65.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // Weather Condition
                                    Text(
                                      data.current.condition.text,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                // Forecast Section
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Forecast for the Next Hours',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 150.h,
                                        child: ListView.builder(
                                          itemCount: data.forecast
                                              .forecastday[0].hour.length,
                                          itemBuilder: (context, index) {
                                           List<dynamic> hour = WeatherModel.;

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    , 
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                      
                                                  Text(
                                                    hour.condition.text,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  // Display the temperature
                                                  Text(
                                                    '${hour.tempC}°C',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ] else ...[
                                Center(
                                  child: Text(
                                    'No data available. Please search for a city.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.white.withOpacity(0.6),
                                      highlightColor:
                                          Colors.white.withOpacity(0.9),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.8)),
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.2),
                                          prefixIcon: const Icon(Icons.search,
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.white.withOpacity(0.6),
                                    highlightColor:
                                        Colors.white.withOpacity(0.9),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Search",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.6),
                                  highlightColor: Colors.white.withOpacity(0.9),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.6),
                                  highlightColor: Colors.white.withOpacity(0.9),
                                  child: Text(
                                    "${value.weather?.location.localtime}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.6),
                                  highlightColor: Colors.white.withOpacity(0.9),
                                  child: const Icon(
                                    Icons.cloud,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.6),
                                  highlightColor: Colors.white.withOpacity(0.9),
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 72.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.6),
                                  highlightColor: Colors.white.withOpacity(0.9),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Shimmer.fromColors(
                              baseColor: Colors.white.withOpacity(0.6),
                              highlightColor: Colors.white.withOpacity(0.9),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.white.withOpacity(0.6),
                                      highlightColor:
                                          Colors.white.withOpacity(0.9),
                                      child: Text(
                                        'Another Cities',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.white.withOpacity(0.6),
                                      highlightColor:
                                          Colors.white.withOpacity(0.9),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Shimmer.fromColors(
                                                  baseColor: Colors.white
                                                      .withOpacity(0.6),
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.9),
                                                  child: Text(
                                                    'Day ${index + 1}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Shimmer.fromColors(
                                                  baseColor: Colors.white
                                                      .withOpacity(0.6),
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.9),
                                                  child: const Text(
                                                    'Cloudy',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Shimmer.fromColors(
                                                  baseColor: Colors.white
                                                      .withOpacity(0.6),
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.9),
                                                  child: const Text(
                                                    '15°C',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
