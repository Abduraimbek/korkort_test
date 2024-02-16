import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korkort_test/common/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.enabled,
  });

  final VoidCallback onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size.fromHeight(50)),
        maximumSize: const MaterialStatePropertyAll(Size.fromHeight(50)),
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(50)),
        foregroundColor: MaterialStatePropertyAll(
          enabled ? Colors.white : const Color(0xFF838FA0),
        ),
        textStyle: MaterialStatePropertyAll(TextStyle(
          fontFamily: GoogleFonts.manrope().fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 26 / 16,
        )),
        backgroundColor: MaterialStatePropertyAll(
          enabled ? kkColorPrimary : const Color(0xFFEAECF0),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(text),
    );
  }
}
