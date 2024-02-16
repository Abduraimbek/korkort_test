import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildAuthProviderButton extends StatelessWidget {
  const BuildAuthProviderButton({
    super.key,
    required this.onPressed,
    required this.svgPath,
  });

  final VoidCallback onPressed;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                width: 1,
                color: Color(0xFFD0D5DD),
              ),
            ),
          ),
          minimumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          fixedSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          maximumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: SvgPicture.asset(
          svgPath,
          fit: BoxFit.cover,
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
