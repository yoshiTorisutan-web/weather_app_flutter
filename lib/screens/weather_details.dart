import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/screens/map_cities.dart';
import '../constants/constants.dart';
import '../models/weather_models.dart';
import '../widgets/weather_item.dart';
import 'favorites.dart';
import 'forecast.dart';

class WeatherDetails extends StatefulWidget {
  final String selectedCity;

  const WeatherDetails({Key? key, required this.selectedCity}) : super(key: key);

  @override
  State<WeatherDetails> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetails> {
  final Constants _constants = Constants();
  final ModelWeather modelWeather = ModelWeather();

  // ignore: non_constant_identifier_names
  

  void fetchWeatherData(String selectedCity) async {
    try {
      var searchResult =
          await http.get(Uri.parse(modelWeather.searchWeatherAPI + selectedCity));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

      var locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        modelWeather.location = getShortLocationName(locationData["name"]);

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        modelWeather.currentDate = newDate;

        //updateWeather
        modelWeather.currentWeatherStatus = currentWeather["condition"]["text"];
        weatherIcon =
            "${modelWeather.currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png";
        modelWeather.temperature = currentWeather["temp_c"].toInt();
        modelWeather.windSpeed = currentWeather["wind_kph"].toInt();
        modelWeather.humidity = currentWeather["humidity"].toInt();
        modelWeather.cloud = currentWeather["cloud"].toInt();

        //Forecast data
        modelWeather.dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        modelWeather.hourlyWeatherForecast = modelWeather.dailyWeatherForecast[0]["hour"];
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  //function to return the first two names of the string location
  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return "${wordList[0]} ${wordList[1]}";
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchWeatherData(widget.selectedCity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;
    String selectedCity = widget.selectedCity;

    return Scaffold(
      backgroundColor: const Color(0xff081b25),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        color: _constants.primaryColor.withOpacity(.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: size.height * .7,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xff2F80ED), Color(0xff56CCF2)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.2, 0.85]),
                  borderRadius: BorderRadius.circular(20),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                        color: Color.fromARGB(100, 47, 129, 237),
                        blurRadius: 3,
                        offset: Offset(0, 10.0))
                  ]),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.favorite,
                              size: 30, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (context) => const Favorites(
                                      selectedCity: '',
                                    )));
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/pin.png",
                            width: 20,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            modelWeather.location,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Hubballi',
                                fontSize: 30),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: IconButton(
                            icon: const Icon(
                              Icons.explore,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MapScreen(selectedCity: selectedCity)));
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child: Image.asset("assets/$weatherIcon"),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          modelWeather.temperature.toString(),
                          style: const TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Hubballi',
                              color: Colors.white),
                        ),
                      ),
                      const Text(
                        '°C',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Hubballi',
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    modelWeather.currentWeatherStatus,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Hubballi'),
                  ),
                  Text(
                    modelWeather.currentDate,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Hubballi'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(
                      color: Color.fromARGB(38, 255, 255, 255),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherItem(
                          value: modelWeather.windSpeed.toInt(),
                          unit: 'km/h',
                          imageUrl: 'assets/windspeed.png',
                        ),
                        WeatherItem(
                          value: modelWeather.humidity.toInt(),
                          unit: '%',
                          imageUrl: 'assets/humidity.png',
                        ),
                        WeatherItem(
                          value: modelWeather.cloud.toInt(),
                          unit: '%',
                          imageUrl: 'assets/cloud.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              height: size.height * .20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                            fontFamily: 'Hubballi'),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailPage(
                                      dailyForecastWeather:
                                          modelWeather.dailyWeatherForecast,
                                    ))), //this will open forecast screen
                        child: const Text(
                          'Forecasts >',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color.fromRGBO(36, 198, 220, 1.0),
                              fontFamily: 'Hubballi'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: modelWeather.hourlyWeatherForecast.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        String currentTime =
                            DateFormat('HH:mm:ss').format(DateTime.now());
                        String currentHour = currentTime.substring(0, 2);

                        String forecastTime = modelWeather.hourlyWeatherForecast[index]
                                ["time"]
                            .substring(11, 16);
                        String forecastHour = modelWeather.hourlyWeatherForecast[index]
                                ["time"]
                            .substring(11, 13);

                        String forecastWeatherName =
                            modelWeather.hourlyWeatherForecast[index]["condition"]["text"];
                        String forecastWeatherIcon =
                            "${forecastWeatherName.replaceAll(' ', '').toLowerCase()}.png";

                        String forecastTemperature =
                            modelWeather.hourlyWeatherForecast[index]["temp_c"]
                                .round()
                                .toString();
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.only(right: 15),
                          width: 65,
                          decoration: BoxDecoration(
                              color: currentHour == forecastHour
                                  ? const Color(0xff2F80ED)
                                  : const Color.fromARGB(255, 5, 16, 21),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(21, 255, 255, 255)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    forecastTemperature,
                                    style: TextStyle(
                                      color: _constants.greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '°C',
                                    style: TextStyle(
                                      color: _constants.greyColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      fontFeatures: const [
                                        FontFeature.enable('sups'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/$forecastWeatherIcon',
                                width: 30,
                              ),
                              Text(
                                forecastTime,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _constants.greyColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
