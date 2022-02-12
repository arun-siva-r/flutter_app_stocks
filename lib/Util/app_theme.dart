import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0XFF171734),
      bottomAppBarColor: Colors.black,
      indicatorColor: const Color(0XFFFFC700),
      cardColor: const Color(0XFF1E1E3D),
      hintColor: const Color(0XFF2F3444),
      iconTheme: const IconThemeData(
        size: 22,
        color: Color(0XFFA2A2AE),
      ),
      textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'Airbnb Cereal App',
              fontWeight: FontWeight.w700,
              fontSize: 36,
              color: Colors.white),
          headline2: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.white),
          headline3: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0XFFD2D2D2)),
          headline4: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white),
          headline5: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0XFF1ACC81)),
          headline6: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0XFFE22716)),
          subtitle1: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white),
          subtitle2: TextStyle(
              fontFamily: 'Airbnb Cereal App',
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white),
          bodyText1: TextStyle(
              fontFamily: 'Airbnb Cereal App',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0XFFFFC700)),
          bodyText2: TextStyle(
              fontFamily: 'Airbnb Cereal App',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          overline: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0XFFA1A1A1)),
          caption: TextStyle(
              fontFamily: 'Test Founders Grotesk',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0XFFA1A1A1))));
}
