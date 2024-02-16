import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildLoginWelcomeText extends StatelessWidget {
  const BuildLoginWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          'Hello 🖐,\nWelcome back!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF27364E),
            fontWeight: FontWeight.w700,
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontSize: 32,
            height: 42 / 32,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter your email and password to log in\nto your account.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF27364E),
            fontSize: 14,
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontWeight: FontWeight.w400,
            height: 24 / 14,
          ),
        ),
      ],
    );
  }
}
