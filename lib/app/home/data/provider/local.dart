import 'package:flutter/material.dart';
import 'package:weather_app/app/home/data/models/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const colorsWeathers = {
  'sun': [
    Color(0xFFfaf15c),
    Color(0xFFffbc2e),
  ],
  'clouds': [
    Color(0xFFffe62e),
    Color(0xFF518ebe),
  ],
};

class WeatherLocalProvider with ChangeNotifier {
  WeatherLocalProvider() {
    _currentWeather = _weathers.first;
    pageController = PageController();
    pageController.addListener(() {
      _currentWeather = _weathers[pageController.page!.round()];
      notifyListeners();
    });
  }

  late WeatherModel _currentWeather;
  late PageController pageController;

  final List<WeatherModel> _weathers = [
    WeatherModel(
      id: 0,
      day: 'Monday',
      asset: 'assets/4791-foggy.json',
      celsius: 20,
      icon: FontAwesomeIcons.sun,
      colors: colorsWeathers['sun']!,
    ),
    WeatherModel(
      id: 1,
      day: 'Tuesday',
      asset: 'assets/4792-weather-stormshowersday.json',
      celsius: 25,
      icon: FontAwesomeIcons.cloud,
      colors: colorsWeathers['clouds']!,
    ),
    WeatherModel(
      id: 2,
      day: 'Wednesday',
      asset: 'assets/4793-weather-snow.json',
      celsius: 35,
      icon: FontAwesomeIcons.sun,
      colors: [
        Colors.yellow,
        Colors.yellowAccent,
      ],
    ),
    WeatherModel(
      id: 3,
      day: 'Thursday',
      asset: 'assets/4795-weather-mist.json',
      celsius: 18,
      icon: FontAwesomeIcons.sun,
      colors: [Colors.orange, Colors.orangeAccent],
    ),
    WeatherModel(
      id: 4,
      day: 'Friday',
      asset: 'assets/4796-weather-cloudynight.json',
      celsius: 15,
      icon: FontAwesomeIcons.cloudSunRain,
      colors: [
        Colors.green,
        Colors.greenAccent,
      ],
    ),
    WeatherModel(
      id: 5,
      day: 'Saturday',
      asset: 'assets/4797-weather-rainynight.json',
      icon: FontAwesomeIcons.moon,
      celsius: 20,
      colors: [
        Colors.deepPurple,
        Colors.deepPurpleAccent,
      ],
    ),
    WeatherModel(
      id: 4,
      day: 'Sunday',
      asset: 'assets/4799-weather-night.json',
      celsius: 31,
      icon: FontAwesomeIcons.cloudSunRain,
      colors: [
        Colors.green,
        Colors.greenAccent,
      ],
    ),
  ];

  List<WeatherModel> get weathers => _weathers;

  WeatherModel get currentWeather => _currentWeather;

  void changeCurrent(WeatherModel weather, int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
