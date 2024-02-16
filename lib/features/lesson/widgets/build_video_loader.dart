import 'package:flutter/material.dart';

class BuildVideoLoader extends StatelessWidget {
  const BuildVideoLoader({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.black,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: Colors.white),
    );
  }
}
