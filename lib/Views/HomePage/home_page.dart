import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Controllers/weather_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/Models/weathers_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<WeatherController>(context, listen: false).reloadCity();
          searchController.clear();
        },
        backgroundColor:
            (Provider.of<WeatherController>(context).weather?.current.tempC ??
                        0) >=
                    20
                ? Colors.yellow.shade300
                : Colors.blue.shade300,
        child: Icon(
          Icons.refresh,
          color:
              (Provider.of<WeatherController>(context).weather?.current.tempC ??
                          0) >=
                      20
                  ? Colors.black
                  : Colors.white,
        ),
      ),
      body: SafeArea(
        child: Consumer<WeatherController>(builder: (context, value, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: (value.weather?.current.tempC ?? 0) >= 20
                    ? [
                        const Color(0xFFFF8A65),
                        const Color(0xFFFFAB91),
                      ]
                    : [
                        const Color(0xFF4A90E2),
                        const Color(0xFF005C97),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  // Search Section
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
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white
                                                  .withOpacity(0.15),
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
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            value.searchCity(
                                                search: searchController.text);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 12,
                                            ),
                                          ),
                                          child: Text(
                                            "Search",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Main Content Section (Location and Weather)
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  if (data != null) ...[
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${data.location.name},",
                                                  style: TextStyle(
                                                    fontSize: 32.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  data.location.region,
                                                  style: TextStyle(
                                                    fontSize: 26.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Text(
                                                  data.location.localtime,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  data.current.condition.text
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains("sunny")
                                                      ? Icons.sunny
                                                      : Icons.cloud,
                                                  color: data.current.condition
                                                          .text
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains("sunny")
                                                      ? Colors.yellow
                                                      : Colors.white,
                                                  size: 100,
                                                ),
                                                SizedBox(height: 20.h),
                                                Text(
                                                  '${data.current.tempC}°C',
                                                  style: TextStyle(
                                                    fontSize: 65.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "${textValues.reverse[data.current.condition.text] ?? data.current.condition.text}",
                                                  style: TextStyle(
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          elevation: 15,
                                          color: Colors.white.withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: (value.weather?.current
                                                                .tempC ??
                                                            0) >=
                                                        20
                                                    ? [
                                                        const Color(0xFFFFD54F),
                                                        const Color(0xFFFFB74D),
                                                      ]
                                                    : [
                                                        const Color(0xFF4A90E2),
                                                        const Color(0xFF005C97),
                                                      ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Humidity: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.humidity}%",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Wind Speed: ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                "${data.current.windKph} km/h",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "UV Index: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.uv}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Cloudiness: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.cloud}%",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Latitude :",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.location.lat}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Wind Chill: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.windchillC}%",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Feels Like: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.feelslikeC}°C",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Pressure: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.pressureMb} mb",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Visibility: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.current.visKm} km",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Temp (F): ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${(data.current.tempF)}°F",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Longitude: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data.location.lon}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Time Zone: ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(
                                                                data.location
                                                                    .tzId,
                                                                style:
                                                                    const TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          elevation: 15,
                                          color: Colors.white.withOpacity(0.1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: (value.weather?.current
                                                                .tempC ??
                                                            0) >=
                                                        20
                                                    ? [
                                                        const Color(0xFFFFD54F),
                                                        const Color(0xFFFFB74D),
                                                      ]
                                                    : [
                                                        const Color(0xFF4A90E2),
                                                        const Color(0xFF005C97),
                                                      ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Forecast for the Next Hours',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    height: 150.h,
                                                    child: ListView.builder(
                                                      itemCount: data
                                                          .forecast
                                                          .forecastday[0]
                                                          .hour
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var hour = data
                                                            .forecast
                                                            .forecastday[0]
                                                            .hour[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 8.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${hour.time}",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Icon(
                                                                hour.condition
                                                                        .text
                                                                        .toString()
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            "sunny")
                                                                    ? Icons
                                                                        .sunny
                                                                    : Icons
                                                                        .cloud,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Text(
                                                                "${hour.tempC}°C",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
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
                                        baseColor:
                                            Colors.white.withOpacity(0.6),
                                        highlightColor:
                                            Colors.white.withOpacity(0.9),
                                        child: TextField(
                                          decoration: InputDecoration(
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
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                        ),
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
                                    highlightColor:
                                        Colors.white.withOpacity(0.9),
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
                                    highlightColor:
                                        Colors.white.withOpacity(0.9),
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
                                    highlightColor:
                                        Colors.white.withOpacity(0.9),
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
                                    highlightColor:
                                        Colors.white.withOpacity(0.9),
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
                                    highlightColor:
                                        Colors.white.withOpacity(0.9),
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
                                        baseColor:
                                            Colors.white.withOpacity(0.6),
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
                                        baseColor:
                                            Colors.white.withOpacity(0.6),
                                        highlightColor:
                                            Colors.white.withOpacity(0.9),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
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
          );
        }),
      ),
    );
  }
}
