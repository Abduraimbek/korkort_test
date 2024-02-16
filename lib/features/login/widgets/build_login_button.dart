import 'package:flutter/material.dart';
import 'package:korkort_test/common/widgets/custom_button.dart';

class BuildLoginButton extends StatelessWidget {
  const BuildLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 54, left: 24, right: 24),
      child: CustomButton(
        onPressed: () {},
        text: 'Register me',
        enabled: true,
      ),
    );
  }
}
