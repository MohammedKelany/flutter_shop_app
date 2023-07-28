import 'package:flutter/material.dart';

class Themes{
  static ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: "Merriweather"
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      cardColor: Colors.blue,
      accentColor:Colors.blueAccent ,
      brightness: Brightness.light,
      backgroundColor: Colors.white
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 10,
    ),

  );
  static ThemeData darkTheme= ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: "Merriweather"
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      accentColor:Colors.blueAccent ,
      brightness: Brightness.dark,
    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      elevation: 10,
    ),

  );
}
