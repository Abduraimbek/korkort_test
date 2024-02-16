import 'package:flutter/material.dart';

import '../widgets/build_login_animated_background.dart';
import '../widgets/build_login_tab_view.dart';
import '../widgets/build_login_welcome_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BuildLoginAnimatedBackground(),
          ),
          Positioned.fill(
            child: Column(
              children: [
                SafeArea(
                  child: BuildLoginWelcomeText(),
                ),
                Expanded(
                  child: BuildLoginTabView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
