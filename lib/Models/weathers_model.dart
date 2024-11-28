import 'package:meta/meta.dart';
import 'dart:convert';

class WeatherModel {
    Current location;
    Current current;
    Forecast forecast;

    WeatherModel({
        required this.location,
        required this.current,
        required this.forecast,
    });

    factory WeatherModel.fromRawJson(String str) => WeatherModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        location: Current.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
        "forecast": forecast.toJson(),
    };
}

class Current {
    Current();

    factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Current.fromJson(Map<String, dynamic> json) => Current(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Forecast {
    List<Forecastday> forecastday;

    Forecast({
        required this.forecastday,
    });

    factory Forecast.fromRawJson(String str) => Forecast.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastday: List<Forecastday>.from(json["forecastday"].map((x) => Forecastday.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
    };
}

class Forecastday {
    DateTime date;
    int dateEpoch;
    Current day;
    Current astro;
    List<Hour> hour;

    Forecastday({
        required this.date,
        required this.dateEpoch,
        required this.day,
        required this.astro,
        required this.hour,
    });

    factory Forecastday.fromRawJson(String str) => Forecastday.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: Current.fromJson(json["day"]),
        astro: Current.fromJson(json["astro"]),
        hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "date_epoch": dateEpoch,
        "day": day.toJson(),
        "astro": astro.toJson(),
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
    };
}

class Hour {
    int timeEpoch;
    String time;
    double tempC;
    double tempF;
    int isDay;
    Condition condition;
    double windMph;
    double windKph;
    int windDegree;
    WindDir windDir;
    int pressureMb;
    double pressureIn;
    int precipMm;
    int precipIn;
    int snowCm;
    int humidity;
    int cloud;
    double feelslikeC;
    double feelslikeF;
    double windchillC;
    double windchillF;
    double heatindexC;
    double heatindexF;
    double dewpointC;
    double dewpointF;
    int willItRain;
    int chanceOfRain;
    int willItSnow;
    int chanceOfSnow;
    int visKm;
    int visMiles;
    double gustMph;
    double gustKph;
    double uv;

    Hour({
        required this.timeEpoch,
        required this.time,
        required this.tempC,
        required this.tempF,
        required this.isDay,
        required this.condition,
        required this.windMph,
        required this.windKph,
        required this.windDegree,
        required this.windDir,
        required this.pressureMb,
        required this.pressureIn,
        required this.precipMm,
        required this.precipIn,
        required this.snowCm,
        required this.humidity,
        required this.cloud,
        required this.feelslikeC,
        required this.feelslikeF,
        required this.windchillC,
        required this.windchillF,
        required this.heatindexC,
        required this.heatindexF,
        required this.dewpointC,
        required this.dewpointF,
        required this.willItRain,
        required this.chanceOfRain,
        required this.willItSnow,
        required this.chanceOfSnow,
        required this.visKm,
        required this.visMiles,
        required this.gustMph,
        required this.gustKph,
        required this.uv,
    });

    factory Hour.fromRawJson(String str) => Hour.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        timeEpoch: json["time_epoch"],
        time: json["time"],
        tempC: json["temp_c"]?.toDouble(),
        tempF: json["temp_f"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windMph: json["wind_mph"]?.toDouble(),
        windKph: json["wind_kph"]?.toDouble(),
        windDegree: json["wind_degree"],
        windDir: windDirValues.map[json["wind_dir"]]!,
        pressureMb: json["pressure_mb"],
        pressureIn: json["pressure_in"]?.toDouble(),
        precipMm: json["precip_mm"],
        precipIn: json["precip_in"],
        snowCm: json["snow_cm"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeC: json["feelslike_c"]?.toDouble(),
        feelslikeF: json["feelslike_f"]?.toDouble(),
        windchillC: json["windchill_c"]?.toDouble(),
        windchillF: json["windchill_f"]?.toDouble(),
        heatindexC: json["heatindex_c"]?.toDouble(),
        heatindexF: json["heatindex_f"]?.toDouble(),
        dewpointC: json["dewpoint_c"]?.toDouble(),
        dewpointF: json["dewpoint_f"]?.toDouble(),
        willItRain: json["will_it_rain"],
        chanceOfRain: json["chance_of_rain"],
        willItSnow: json["will_it_snow"],
        chanceOfSnow: json["chance_of_snow"],
        visKm: json["vis_km"],
        visMiles: json["vis_miles"],
        gustMph: json["gust_mph"]?.toDouble(),
        gustKph: json["gust_kph"]?.toDouble(),
        uv: json["uv"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "time_epoch": timeEpoch,
        "time": time,
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition.toJson(),
        "wind_mph": windMph,
        "wind_kph": windKph,
        "wind_degree": windDegree,
        "wind_dir": windDirValues.reverse[windDir],
        "pressure_mb": pressureMb,
        "pressure_in": pressureIn,
        "precip_mm": precipMm,
        "precip_in": precipIn,
        "snow_cm": snowCm,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_c": feelslikeC,
        "feelslike_f": feelslikeF,
        "windchill_c": windchillC,
        "windchill_f": windchillF,
        "heatindex_c": heatindexC,
        "heatindex_f": heatindexF,
        "dewpoint_c": dewpointC,
        "dewpoint_f": dewpointF,
        "will_it_rain": willItRain,
        "chance_of_rain": chanceOfRain,
        "will_it_snow": willItSnow,
        "chance_of_snow": chanceOfSnow,
        "vis_km": visKm,
        "vis_miles": visMiles,
        "gust_mph": gustMph,
        "gust_kph": gustKph,
        "uv": uv,
    };
}

class Condition {
    Text text;
    Icon icon;
    int code;

    Condition({
        required this.text,
        required this.icon,
        required this.code,
    });

    factory Condition.fromRawJson(String str) => Condition.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: textValues.map[json["text"]]!,
        icon: iconValues.map[json["icon"]]!,
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "text": textValues.reverse[text],
        "icon": iconValues.reverse[icon],
        "code": code,
    };
}

enum Icon {
    CDN_WEATHERAPI_COM_WEATHER_64_X64_DAY_113_PNG,
    CDN_WEATHERAPI_COM_WEATHER_64_X64_NIGHT_113_PNG
}

final iconValues = EnumValues({
    "//cdn.weatherapi.com/weather/64x64/day/113.png": Icon.CDN_WEATHERAPI_COM_WEATHER_64_X64_DAY_113_PNG,
    "//cdn.weatherapi.com/weather/64x64/night/113.png": Icon.CDN_WEATHERAPI_COM_WEATHER_64_X64_NIGHT_113_PNG
});

enum Text {
    CLEAR,
    SUNNY
}

final textValues = EnumValues({
    "Clear ": Text.CLEAR,
    "Sunny": Text.SUNNY
});

enum WindDir {
    E,
    ENE,
    ESE,
    NE
}

final windDirValues = EnumValues({
    "E": WindDir.E,
    "ENE": WindDir.ENE,
    "ESE": WindDir.ESE,
    "NE": WindDir.NE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
