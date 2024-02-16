import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildOrSignInWithDivider extends StatelessWidget {
  const BuildOrSignInWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    Widget divider() {
      return const Expanded(
        child: Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFD0D5DD),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 17,
        right: 17,
        top: 14,
        bottom: 18,
      ),
      child: Row(
        children: [
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Or sign in with',
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 22.4 / 14,
                color: const Color(0xFF101828),
              ),
            ),
          ),
          divider(),
        ],
      ),
    );
  }
}
