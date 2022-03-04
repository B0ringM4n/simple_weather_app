import 'package:flutter/material.dart';

class WeatherModel {
  WeatherModel({
    required this.id,
    required this.day,
    required this.asset,
    required this.celsius,
    required this.icon,
    required this.colors,
  });

  final int id;
  final String day;
  final String asset;
  final double celsius;
  final IconData icon;
  final List<Color> colors;
}
