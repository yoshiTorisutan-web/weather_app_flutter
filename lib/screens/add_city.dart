import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:weather_app/screens/favorites.dart';
import '../models/cities_models.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({super.key, required String selectedCity});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  List<String> _cities = [];
  late stt.SpeechToText _speech;
  String _text = '';
  bool _isListening = false;
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              _searchController.text = _text;
              fetchCities(_text).then((cities) {
                _cities = cities;
                setState(() {});
              });
            });
          },
        );
      }
    }
  }

  void _stop() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Add a city",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Hubballi',
              color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.mic),
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            onPressed: () => _listen(),
          ),
          Visibility(
            visible: _isListening,
            child: IconButton(
              icon: const Icon(Icons.stop),
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              onPressed: () => _stop(),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: size.width,
        height: size.height,
        color: const Color(0xff081b25),
        child: Form(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0,
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _searchController,
                  onChanged: (value) async {
                    _cities = await fetchCities(value);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2)),
                    filled: true,
                    fillColor: const Color.fromARGB(61, 255, 255, 255),
                    hintText: 'ex : Angers',
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Hubballi',
                        fontSize: 20),
                    labelText: 'City',
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Hubballi',
                        fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                  child: Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0,
                color: const Color.fromARGB(61, 255, 255, 255),
                margin: const EdgeInsets.only(
                    top: 15, left: 25, right: 25, bottom: 100),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _cities.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 0),
                  itemBuilder: (BuildContext context, int index) {
                    final city = _cities[index];
                    final cityData = city.split(', ');
                    final cityName = cityData[0];
                    final countryName = cityData[2];
                    return ListTile(
                      title: Text(cityName,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      subtitle: Text(countryName,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 12)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('selectedCity', cityName);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Favorites(selectedCity: cityName),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Entreprise ajouté ✅'), backgroundColor: Colors.green),
                        );
                      },
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Search info location',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Hubballi')),
                    content: const Text(
                        'Discover the weather of any city in France, Europe and the World (ex: Paris, Madrid, New-York).',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Hubballi',
                            fontSize: 20)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Understood'),
                        child: const Text(
                          'Understood',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Hubballi',
                              fontSize: 19),
                        ),
                      ),
                    ],
                  ));
        },
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.info, color: Color(0xff081b25)),
      ),
    );
  }
}
