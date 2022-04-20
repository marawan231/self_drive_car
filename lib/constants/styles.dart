import 'package:flutter/material.dart';

import 'colors.dart';

const boardItemText1 = 'Welcome To Our Shop';
TextStyle onBoardinTextStyle = const TextStyle(
  fontFamily: 'Nunito',
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
);

const titleTextStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: onBoardingTextColor);

final bodyTextStyle = TextStyle(
  fontFamily: 'Nunito',
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  color: onBoardingTextColor.withOpacity(.6),
);

final textButtonStyle = TextButton.styleFrom(
  backgroundColor: onBoardingTextButtonColor,
  padding: const EdgeInsets.symmetric(
    horizontal: 120,
    vertical: 15,
  ),
);

const textInTextButtonStyle = TextStyle(color: Colors.white);
const Widget horzintalSpace = SizedBox(
  height: 25,
);
const Widget doubleHorzintalSpace = SizedBox(
  height: 50,
);
Decoration containerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  gradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      tileMode: TileMode.mirror,
      colors: [
        Color(0xFFcdacf9),
        Color(0xFF4568dc),
        // Color(0xFF4568dc),
        //Color(0xFFb06ab3),
      ]),
);

const containerDicoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
);
