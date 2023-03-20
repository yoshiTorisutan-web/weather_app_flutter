import 'package:flutter/material.dart';

class InfoFavorites extends StatelessWidget {
  const InfoFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Favourites places',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Hubballi',
              color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 90),
          width: size.width,
          height: size.height,
          color: const Color(0xff081b25),
          child: const Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: Text(
                'Your favourite location will be used to provide weather information. You can change your favourite location in your list of locations.',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 16)),
          )),
    );
  }
}
