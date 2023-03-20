import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final String selectedCity; // Ville sélectionnée depuis une autre page

  const MapScreen({super.key, required this.selectedCity});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? cityLocation;

  void getCityLocation() async {
    String cityName = widget.selectedCity;

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$cityName&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.isNotEmpty) {
        double lat = double.parse(data[0]['lat']);
        double lon = double.parse(data[0]['lon']);
        cityLocation = LatLng(lat, lon);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCityLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff081b25),
        title: Text(widget.selectedCity,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Hubballi',
                color: Colors
                    .white)), // Afficher le nom de la ville sélectionnée dans la barre d'applications
      ),
      body: (cityLocation == null)
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: cityLocation,
                zoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    if (cityLocation != null)
                      Marker(
                        point: cityLocation!,
                        builder: (ctx) => const Icon(Icons.location_on,
                            color: Colors.red, size: 20),
                      ),
                    if (cityLocation == null)
                      Marker(
                        point:
                            LatLng(0.0, 0.0), // Position du marqueur par défaut
                        builder: (ctx) => const CircularProgressIndicator(),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}
