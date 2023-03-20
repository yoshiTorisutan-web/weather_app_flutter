import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/default_cities.dart';
import 'package:weather_app/screens/add_city.dart';
import 'package:weather_app/screens/favorites.dart';
import 'package:weather_app/screens/forecast.dart';
import 'package:weather_app/screens/weather_details.dart';
import 'package:weather_app/screens/map_cities.dart';

import 'blocs/theme.dart';
import 'screens/welcome.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DefaultCities(),
      child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => const Start(),
        '/favorites': (context) => const Favorites(selectedCity: ''),
        '/add_city': (context) => const SearchCity(selectedCity: ''),
        '/weather_details': (context) => const WeatherDetails(selectedCity: ''),
        '/forecast': (context) => const DetailPage(),
        '/map': (context) => const MapScreen(selectedCity: ''),
      },
      initialRoute: '/welcome',
    ));
  }
}