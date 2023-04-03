import 'dart:convert';
import 'package:http/http.dart' as http;

String apiKey = '9d54e695bf4b4803aee230828231202';

Future<List<String>> fetchCities(String query) async {
  final url = Uri.parse(
      'https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$query');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    final cities = data
        .map((city) => '${city['name']}, ${city['region']}, ${city['country']}')
        .toList()
        .cast<String>();
    return cities;
  } else {
    throw Exception('Failed to load cities');
  }
}
