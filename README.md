# Flutter Weather Application 🌤️

A Flutter application that provides real-time weather forecasts for any city using the [WeatherAPI](https://www.weatherapi.com/) and leverages the **Provider** package for state management.

---

## Features 🚀
- **Current Weather**: Displays the current weather conditions like temperature, humidity, wind speed, and more.
- **Weather Forecast**: Provides weather forecasts for the upcoming days.
- **Search by City**: Search for weather updates by entering the name of any city.
- **Real-time Updates**: Fetches live data from the WeatherAPI.
- **State Management**: Efficiently managed using the **Provider** package.

---

## Installation 🛠️
1. Clone the repository:
   ```bash
   git clone https://github.com/your_username/flutter_weather_app.git
   cd flutter_weather_app

2. Install the required dependencies
    ### flutter pub get

3. Run the app
    ### flutter run

## Api Usage 🌐
    ### The application uses the WeatherAPI for fetching weather data. You can register at WeatherAPI to get your free API key.

    API Endpoint:
    http://api.weatherapi.com/v1/forecast.json?key=YOUR_API_KEY&q=$city

## Screen Shots



## State Management 🧑‍💻
    ### This app uses the Provider package for managing the state efficiently. It ensures the UI updates seamlessly with changes in weather data.

## Code Structure 📂lib/
├── main.dart
├── models/
│   └── weather_model.dart
├── providers/
│   └── weather_provider.dart
├── services/
│   └── weather_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── weather_detail_screen.dart
├── widgets/
│   ├── weather_card.dart
│   └── search_bar.dart
└── utils/
    └── constants.dart


