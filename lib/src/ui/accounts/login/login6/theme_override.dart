import 'package:flutter/material.dart';
import 'package:gradient_input_border/gradient_input_border.dart';

class ThemeOverride extends StatelessWidget {
   ThemeOverride({Key key, this.child}) : super(key: key);
  final Widget child;

  final LinearGradient lightgradient = LinearGradient(
    begin: Alignment.centerLeft, end: Alignment.centerRight,
    colors: [
      Color(0xff02A4E6),
      Color(0xff041F5F),
    ]
  );
   final LinearGradient darkGradient = LinearGradient(
       begin: Alignment.centerLeft, end: Alignment.centerRight,
       colors: [
         Color(0xff212121),
         Color(0xffbdbdbd)
       ]
   );
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          height: 45.0,
          colorScheme: ColorScheme(
              primary: Colors.red,//const Color(0xff3700b3),
              secondary: Color(0xffbdbdbd),
              surface: Colors.white,
              error: Color(0xffb00020),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            focusedGradient: darkGradient,
            unfocusedGradient: darkGradient,
            borderSide:
            BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            BorderSide(color: Colors.red, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            BorderSide(color: Colors.red, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xffbdbdbd)), colorScheme: ColorScheme(background: isDark ? Colors.black : Colors.white),
      ),
      child: child,
    ) : Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[500],
        scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          height: 45.0,
          colorScheme: ColorScheme(
              primary: Colors.red,//const Color(0xff3700b3),
              secondary: Color(0xff03dac6),
              surface: Colors.white,
              error: Color(0xffb00020),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: GradientOutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            focusedGradient: lightgradient,
            unfocusedGradient: lightgradient,
            borderSide:
            BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            BorderSide(color: Colors.red, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            BorderSide(color: Colors.red, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan[600]), colorScheme: ColorScheme(background: isDark ? Colors.black : Colors.white),
      ),
      child: child,
    );
  }
}