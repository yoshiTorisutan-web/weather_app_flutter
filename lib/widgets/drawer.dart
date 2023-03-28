import 'package:flutter/material.dart';

import '../screens/author.dart';
import '../screens/info_favorites.dart';
import '../screens/settings.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff081b25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Image.asset(
                    'assets/logo_weather.png',
                    width: 75,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text("Weather_App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Hubballi'))
                ],
              ),
            ),
            const Divider(color: Colors.white),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text(
                'Favourite places',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Hubballi',
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InfoFavorites()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Settings',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Hubballi',
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Creator',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Hubballi',
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Author()));
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image.asset(
                      'assets/logo_mds.png',
                      width: 75,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
