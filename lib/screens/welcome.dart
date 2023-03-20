import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'favorites.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xff081b25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_weather.png',
                width: 250,
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Discover the Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hubballi',
                    ),
                  ),
                  Text(
                    'in Your City',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hubballi',
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Find out about the current and',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hubballi',
                    ),
                  ),
                  Text(
                    'future weather in your city.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hubballi',
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureBuilder(
                                future: Future.delayed(
                                    const Duration(seconds: 5),
                                    () => "Data Loaded"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Scaffold(
                                      backgroundColor: const Color(0xff081b25),
                                      body: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            LoadingAnimationWidget.inkDrop(
                                              color: const Color(0xff2F80ED),
                                              size: 50,
                                            ),
                                            const SizedBox(height: 20),
                                            const Padding(
                                                padding: EdgeInsets.all(10)),
                                            const Text(
                                              'Loading ...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.0,
                                                  fontFamily: 'Hubballi'),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Favorites(
                                      selectedCity: '',
                                    );
                                  }
                                },
                              )));
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.6,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff2F80ED), Color(0xff56CCF2)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.2, 0.85]),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Hubballi',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
