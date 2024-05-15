import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData themeData = ThemeData(
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 23),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      color: Color.fromARGB(255, 23, 23, 23),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.only(bottom: 10),
      prefixIconColor: Colors.white,
      hintStyle:
          TextStyle(color: Color.fromARGB(70, 255, 255, 255), fontSize: 15),
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.purple), //
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.white), //
      ),
    ),
    // HomeScreen
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 20,
      ),
      titleMedium: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 25,
          fontWeight: FontWeight.bold),
      titleSmall: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      // TasksListViewWidget
      displayLarge: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 25,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
      displayMedium: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 18,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis),
      displaySmall: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 15,
          fontWeight: FontWeight.w300,
          overflow: TextOverflow.ellipsis),
      // TaskInfoScreen
      bodyLarge: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 25,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          decoration: TextDecoration.lineThrough),
      labelSmall: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.black,
    ),
  );
  static final ThemeData textFieldTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      isDense: false,
      border: const OutlineInputBorder(),
    ),
  );
  static final ThemeData completedTextTheme = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 25,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough,
        decorationThickness: 5,
      ),
      displayMedium: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough,
        decorationThickness: 5,
      ),
      displaySmall: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 15,
        fontWeight: FontWeight.w300,
        overflow: TextOverflow.ellipsis,
        decoration: TextDecoration.lineThrough,
        decorationThickness: 5,
      ),
    ),
  );
  static final ThemeData favoriteTextTheme = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.pink.withOpacity(0.9),
        fontSize: 25,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        decorationThickness: 5,
      ),
      displayMedium: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        decorationThickness: 5,
      ),
      displaySmall: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 15,
        fontWeight: FontWeight.w300,
        overflow: TextOverflow.ellipsis,
        decorationThickness: 5,
      ),
    ),
  );
}
