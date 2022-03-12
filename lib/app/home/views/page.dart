import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/app/home/data/models/weather.dart';
import 'package:weather_app/app/home/data/provider/local.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherLocalProvider>(
      create: (context) => WeatherLocalProvider(),
      child: Scaffold(
        body: Stack(
          children: const [
            _BackgroundView(),
            _Content(),
          ],
        ),
      ),
    );
  }
}

class _BackgroundView extends StatelessWidget {
  const _BackgroundView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherLocalProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: provider.currentWeather.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          SizedBox(height: 20),
          _Header(),
          _WeatherView(),
          _WeatheWeek()
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'City',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _WeatherView extends StatelessWidget {
  const _WeatherView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherLocalProvider>(context);

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: PageView.builder(
          controller: provider.pageController,
          itemCount: provider.weathers.length,
          // onPageChanged: (value) =>
          //     provider.cah = provider.weathers[value],
          itemBuilder: (cxt, index) {
            return Container(
              margin: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    '${provider.weathers[index].celsius.toStringAsFixed(0)}°',
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Lottie.asset(
                      provider.weathers[index].asset,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WeatheWeek extends StatelessWidget {
  const _WeatheWeek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherLocalProvider>(context);

    return Column(
      children: [
        Text(
          provider.currentWeather.day,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ListView.separated(
            primary: true,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: provider.weathers.length,
            separatorBuilder: (context, index) => const SizedBox(width: 4),
            itemBuilder: (ctx, index) {
              return _IconWeatherWeek(
                isSelected: provider.currentWeather == provider.weathers[index],
                item: provider.weathers[index],
                onTap: (item) => provider.changeCurrent(item, index),
              );
            },
          ),
        )
      ],
    );
  }
}

class _IconWeatherWeek extends StatelessWidget {
  const _IconWeatherWeek({
    Key? key,
    required this.isSelected,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final WeatherModel item;
  final Function(WeatherModel) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.white30,
          primary: Colors.white,
        ),
        onPressed: () => onTap(item),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              item.icon,
              size: 25,
              color: Colors.black,
            ),
            Text(
              '${item.celsius.toStringAsFixed(0)}°',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
