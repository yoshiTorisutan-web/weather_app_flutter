import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';
import '../widgets/weather_item.dart';
import 'weather_details.dart';

class DetailPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dailyForecastWeather;

  const DetailPage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    //function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          "${weatherName.replaceAll(' ', '').toLowerCase()}.png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: const Color(0xff081b25),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 25.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pop(MaterialPageRoute(builder: (context) => const WeatherDetails(selectedCity: '')));
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32.0, left: 8.0),
              child: Text(
                'Forecasts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 25.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Detailed weather information',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    fontFamily: 'Hubballi')),
                            content: const Text(
                                'Find out the detailed weather forecast for the city you have selected: weather and temperature (min and max) for the next 3 days.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Hubballi',
                                    fontSize: 20)),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Understood'),
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
                icon: const Icon(Icons.info, color: Colors.white)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 10,
            child: Container(
              height: size.height * .70,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 34, 56, 69),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -130,
                    right: 30,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [Color(0xff2F80ED), Color(0xff56CCF2)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            width: 110,
                            left: 40,
                            top: 30,
                            // ignore: prefer_interpolation_to_compose_strings
                            child: Image.asset("assets/" +
                                getForecastWeather(0)["weatherIcon"]),
                          ),
                          Positioned(
                              top: 160,
                              left: 65,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Hubballi'),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 15,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            right: 30,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Hubballi',
                                      color: Colors.white),
                                ),
                                const Text(
                                  '°C',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Hubballi'),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 340,
                            right: 5,
                            left: 5,
                            child: SizedBox(
                              height: 400,
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Card(
                                    color: Colors.white,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    0)["forecastDate"],
                                                style: const TextStyle(
                                                  color: Color(0xff2F80ED),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°C',
                                                        style: TextStyle(
                                                            color: _constants
                                                                .greyColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°C',
                                                        style: TextStyle(
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/' +
                                                        getForecastWeather(
                                                            0)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        0)["weatherName"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${getForecastWeather(0)["chanceOfRain"]}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    1)["forecastDate"],
                                                style: const TextStyle(
                                                  color: Color(0xff2F80ED),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°C',
                                                        style: TextStyle(
                                                            color: _constants
                                                                .greyColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°C',
                                                        style: TextStyle(
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/' +
                                                        getForecastWeather(
                                                            1)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        0)["weatherName"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${getForecastWeather(1)["chanceOfRain"]}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    2)["forecastDate"],
                                                style: const TextStyle(
                                                  color: Color(0xff2F80ED),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°C',
                                                        style: TextStyle(
                                                            color: _constants
                                                                .greyColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°C',
                                                        style: TextStyle(
                                                            color: _constants
                                                                .blackColor,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFeatures: const [
                                                              FontFeature
                                                                  .enable(
                                                                      'sups'),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'assets/' +
                                                        getForecastWeather(
                                                            2)["weatherIcon"],
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        2)["weatherName"],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "${getForecastWeather(2)["chanceOfRain"]}%",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
