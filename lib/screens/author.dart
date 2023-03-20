import 'package:flutter/material.dart';

class Author extends StatelessWidget {
  const Author({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Creator',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Hubballi',
              color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xff081b25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('assets/logo_perso.png'),
                radius: 100,
              ),
              SizedBox(
                height: 60,
              ),
              Text('Directed by Tristan.',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Hubballi',
                      fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}
