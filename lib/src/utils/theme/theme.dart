import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JarvisTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.montserrat(color: Colors.black),
        headlineSmall: GoogleFonts.montserrat(color: Colors.black),
        bodyMedium: GoogleFonts.montserrat(color: Colors.black),
        displaySmall: GoogleFonts.montserrat(color: Colors.black),
      ));
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
          headlineLarge: GoogleFonts.montserrat(color: Colors.black),
          headlineSmall: GoogleFonts.montserrat(color: Colors.black),
          bodyMedium: GoogleFonts.montserrat(color: Colors.grey),
          displaySmall: GoogleFonts.montserrat(color: Colors.grey)));
}
