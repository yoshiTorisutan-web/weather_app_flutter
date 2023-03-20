import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/theme.dart';
import '../widgets/drawer.dart';
import 'add_city.dart';
import 'weather_details.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key, required this.selectedCity});

  final String selectedCity;

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String selectedCity = '';

  @override
  void initState() {
    super.initState();
    getSelectedCity();
  }

  Future<void> getSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedCity = prefs.getString('selectedCity') ?? '';
    setState(() {
      this.selectedCity = selectedCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final now = TimeOfDay.now();
    String image;

    List<String> defaultCities = ['New York', 'Paris', 'Tokyo', 'Madrid'];
    List<String> cities = <String>[...defaultCities];
    if (selectedCity.isNotEmpty) {
      cities.add(selectedCity);
    }

    if (now.hour >= 0 && now.hour < 6) {
      image = "assets/pleine-lune.png";
    } else if (now.hour >= 6 && now.hour < 19) {
      image = "assets/soleil.png";
    } else {
      image = "assets/pleine-lune.png";
    }

    return ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(builder: (context, provider, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: provider.isDarkMode
                  ? ThemeData.dark().copyWith(
                      backgroundColor: const Color(0xff081b25),
                      primaryColor: Colors.white)
                  : ThemeData.light().copyWith(
                      backgroundColor: Colors.white,
                      primaryColor: Colors.black),
              home: Scaffold(
                backgroundColor: provider.isDarkMode
                    ? const Color(0xff081b25)
                    : Colors.white,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                      color: provider.isDarkMode ? Colors.white : Colors.black),
                  title: Text(
                    "Manage cities",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Hubballi',
                        color:
                            provider.isDarkMode ? Colors.white : Colors.black),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                          provider.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: provider.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      padding: const EdgeInsets.all(10.0),
                      onPressed: () {
                        provider.toggleTheme();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add,
                          color: provider.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      padding: const EdgeInsets.all(10.0),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SearchCity(
                                  selectedCity: '',
                                )));
                      },
                    )
                  ],
                ),
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 20,
                      right: 20,
                      left: 20,
                      child: Container(
                        height: 150,
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
                              width: 90,
                              left: 35,
                              top: 30,
                              // ignore: prefer_interpolation_to_compose_strings
                              child: Image.asset(image),
                            ),
                            const Positioned(
                                top: 80,
                                right: 41,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "How are you today ?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Hubballi'),
                                  ),
                                )),
                            Positioned(
                              top: 45,
                              right: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    "Hello, Tristan !",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Hubballi',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 210.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "❤️ Favourite Places ❤️",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Hubballi',
                                color: provider.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: cities.length,
                      padding: const EdgeInsets.only(top: 240),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: const Color(0xff56CCF2),
                          elevation: 5,
                          margin: const EdgeInsets.only(
                              top: 10, left: 30, right: 30, bottom: 10),
                          child: cities[index].isEmpty
                              ? Container()
                              : ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  contentPadding: const EdgeInsets.only(
                                      top: 5, bottom: 5, right: 15, left: 15),
                                  leading: const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
                                      child: Icon(Icons.location_on,
                                          color: Color.fromARGB(
                                              255, 254, 254, 254))),
                                  title: Text(
                                    cities[index],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Hubballi',
                                    ),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WeatherDetails(
                                                      selectedCity:
                                                          cities[index],
                                                    ))); // Navigue vers la page WeatherPage
                                      },
                                      icon: const Icon(Icons.chevron_right,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          size: 30)),
                                ),
                        );
                      },
                    )
                  ],
                ),
                drawer: const Drawer(child: MainDrawer()),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Favourite city information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      fontFamily: 'Hubballi')),
                              content: const Text(
                                  'You will find here all the cities added by default by the application and added by you as you wish.',
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
                  backgroundColor: provider.isDarkMode
                      ? Colors.white
                      : const Color(0xff081b25),
                  child: Icon(Icons.info,
                      color: provider.isDarkMode ? Colors.black : Colors.white),
                ),
              ));
        }));
  }
}
