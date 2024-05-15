import 'package:flutter/material.dart';

abstract class AppConstants {
  static BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: const BorderRadius.all(Radius.circular(10)));

  static ButtonStyle elevatedButtonStyle = const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 23, 23, 23)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        side: BorderSide(color: Colors.white),
      ),
    ),
  );
  static BoxDecoration addNewTaskBoxDecoration = const BoxDecoration(
    color: Color.fromARGB(255, 23, 23, 23),
  );
}
