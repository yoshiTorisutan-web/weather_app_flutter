import 'package:flutter/material.dart';

class Constants {
  final primaryColor = const Color(0xff081b25);
  final secondaryColor = const Color(0xffa1c6fd);
  final tertiaryColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff1a1d26);

  final greyColor = const Color(0xffd9dadb);

  final linearGradientBlue =  const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Color(0xff955cd1), Color(0xff3fa2fa)],
      stops: [0.0,1.0]
  );
  final linearGradientPurple =  const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff51087E), Color(0xff6C0BA9)],
      stops: [0.0,1.0]
  );
}