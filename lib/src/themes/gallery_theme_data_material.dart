// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: unnecessary_new, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GalleryThemeData {


  static ThemeData lightThemeData = themeDataLight();
  static ThemeData darkThemeData = themeDataDark();

  static ThemeData lightArabicThemeData = themeArabicDataLight();
  static ThemeData darkArabicThemeData = themeArabicDataDark();

  static ThemeData themeDataLight() {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.red,
      //*** For White App Bar ***/
      primaryTextTheme: _textTheme.apply(bodyColor: Colors.black),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      primaryIconTheme: IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black,
        labelColor: Colors.black,),


        buttonTheme: ButtonThemeData(
        buttonColor: Colors.red,
        //shape: StadiumBorder(),
        textTheme: ButtonTextTheme.primary,
        height: 45.0,
        colorScheme: new ColorScheme(
            primary: Colors.red,//const Color(0xff3700b3),
            secondary: Color(0xff03dac6),
            surface: Colors.white,
            error: Color(0xffb00020),
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData themeDataDark() {
    return ThemeData(
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor:Color(0xff03dac6),
          //shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
          height: 45.0,
          colorScheme: new ColorScheme(
              primary: Color(0xff03dac6),
              secondary: const Color(0xff03dac6),
              surface: const Color(0xff121212),
              error: Color(0xffb00020),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: Colors.black87
    );
  }

  static ThemeData themeArabicDataLight() {
    return ThemeData(
      primarySwatch: Colors.red,

      //*** For White App Bar ***/
      primaryTextTheme: _textTheme.apply(bodyColor: Colors.black),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      primaryIconTheme: IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black,
        labelColor: Colors.black,),


      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green,
        //shape: StadiumBorder(),
        textTheme: ButtonTextTheme.primary,
        height: 45.0,
        colorScheme: new ColorScheme(
            primary: Colors.green,//const Color(0xff3700b3),
            secondary: Color(0xff03dac6),
            surface: Colors.white,
            error: Color(0xffb00020),
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData themeArabicDataDark() {
    return ThemeData(
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor:Color(0xff03dac6),
          //shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
          height: 45.0,
          colorScheme: new ColorScheme(
              primary: Color(0xff03dac6),
              secondary: const Color(0xff03dac6),
              surface: const Color(0xff121212),
              error: Color(0xffb00020),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: Colors.black87,
        colorScheme: ColorScheme(
          primary: Colors.black,
          secondary: Colors.grey,
          surface: Colors.black,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        )
    );
  }

  static final TextTheme _textTheme = TextTheme(
    headlineSmall: _GalleryTextStyles.display1,
    headlineMedium: _GalleryTextStyles.display2,
    displayMedium: _GalleryTextStyles.display3,
    displayLarge: _GalleryTextStyles.display4,
    bodySmall: _GalleryTextStyles.studyTitle,
    titleMedium: _GalleryTextStyles.listTitle,
    labelSmall: _GalleryTextStyles.listDescription,
    bodyMedium: _GalleryTextStyles.sliderTitle,
    titleSmall: _GalleryTextStyles.settingsFooter,
    bodyLarge: _GalleryTextStyles.options,
    titleLarge: _GalleryTextStyles.title,
    labelLarge: _GalleryTextStyles.button,
  );

}

class _GalleryTextStyles {
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static const _montserrat = 'Montserrat';
  static const _oswald = 'Oswald';

  static const display1 = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _bold,
    fontSize: 16.0,
  );

  static const display2 = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _bold,
    fontSize: 14.0,
  );

  static const display3 = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _bold,
    fontSize: 12.0,
  );

  static const display4 = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _bold,
    fontSize: 10.0,
  );

  static const studyTitle = TextStyle(
    //fontFamily: _oswald,
    fontWeight: _semiBold,
    fontSize: 16.0,
  );

  static const categoryTitle = TextStyle(
    //fontFamily: _oswald,
    fontWeight: _medium,
    fontSize: 16.0,
  );

  static const listTitle = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _medium,
    fontSize: 16.0,
  );

  static const listDescription = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _medium,
    fontSize: 12.0,
  );

  static const sliderTitle = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _regular,
    fontSize: 14.0,
  );

  static const settingsFooter = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _medium,
    fontSize: 14.0,
  );

  static const options = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _regular,
    fontSize: 16.0,
  );

  static const title = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _bold,
    fontSize: 16.0,
  );

  static const button = TextStyle(
    //fontFamily: _montserrat,
    fontWeight: _semiBold,
    fontSize: 14.0,
  );
}


ColorScheme lightColorScheme = ColorScheme(
  primary: Colors.blue,
  secondary: Colors.blue[700] ?? Colors.blue,
  surface: const Color(0xFFFFFFFF),
  error: Colors.black,
  onError: Colors.black,
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onSurface: const Color(0xFF241E30),
  brightness: Brightness.light,
);