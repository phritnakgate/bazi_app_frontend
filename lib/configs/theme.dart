import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color fcolor = const Color(0xFF2D4262);

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF862D2D),
  disabledColor: const Color(0xFFD9D9D9),
  focusColor: fcolor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: fcolor),
    ),
    floatingLabelStyle: TextStyle(color: fcolor),
  ),
  textTheme: GoogleFonts.kanitTextTheme(),
);
