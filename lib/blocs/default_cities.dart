import 'package:flutter/material.dart';

class DefaultCities extends ChangeNotifier {
  final List<String> _citiesList = [];

  // ignore: recursive_getters
  List<String> get citiesList => citiesList;

  add(String cities){
    _citiesList.add(cities);
    notifyListeners();
  }

  remove(String cities){
    _citiesList.removeWhere((element) => element == cities);
    notifyListeners();
  }
}