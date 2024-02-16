import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData get getTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kkColorPrimary,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: kkColorAppBarBackground,
      surfaceTintColor: kkColorAppBarBackground,
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ).fontFamily,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
