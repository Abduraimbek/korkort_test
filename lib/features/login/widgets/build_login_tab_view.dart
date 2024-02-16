import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korkort_test/common/theme/colors.dart';

import 'build_auth_provider_button.dart';
import 'build_login_button.dart';
import 'build_or_sign_in_with_divider.dart';

class BuildLoginTabView extends StatelessWidget {
  const BuildLoginTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 23,
              ),
              child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.all(6),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: const Color(0xFFEAECF0),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: kkColorPrimary,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF2C4364),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontSize: 14,
                    height: 24 / 14,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontSize: 14,
                    height: 24 / 14,
                  ),
                  tabs: const [
                    Tab(text: 'Sign Up'),
                    Tab(text: 'Log In'),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(),
            ),
            const BuildOrSignInWithDivider(),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, bottom: 33),
              child: Row(
                children: [
                  BuildAuthProviderButton(
                    onPressed: () {},
                    svgPath: 'assets/svg/logos_google-icon.svg',
                  ),
                  const SizedBox(width: 15),
                  BuildAuthProviderButton(
                    onPressed: () {},
                    svgPath: 'assets/svg/basil_apple-solid.svg',
                  ),
                  const SizedBox(width: 15),
                  BuildAuthProviderButton(
                    onPressed: () {},
                    svgPath: 'assets/svg/logos_facebook.svg',
                  ),
                ],
              ),
            ),
            const BuildLoginButton(),
          ],
        ),
      ),
    );
  }
}
