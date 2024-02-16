import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomAppBarButton extends StatelessWidget {
  const CustomAppBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButtonTheme(
      data: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: const MaterialStatePropertyAll(kkColorPrimary),
          backgroundColor: MaterialStatePropertyAll(
            kkColorPrimary.withOpacity(0.2),
          ),
          overlayColor: MaterialStatePropertyAll(
            kkColorPrimary.withOpacity(0.2),
          ),
          minimumSize: const MaterialStatePropertyAll(Size(35, 35)),
          maximumSize: const MaterialStatePropertyAll(Size(35, 35)),
          fixedSize: const MaterialStatePropertyAll(Size(35, 35)),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        ),
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
