import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/question.dart';

class BuildQuestionText extends StatelessWidget {
  const BuildQuestionText({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 34, right: 24),
        child: Text(
          question.text,
          style: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 24 / 16,
          ),
        ),
      ),
    );
  }
}
