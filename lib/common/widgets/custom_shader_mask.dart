import 'package:flutter/material.dart';

class CustomShaderMask extends StatelessWidget {
  const CustomShaderMask({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          // This gradient goes from fully transparent to fully opaque black...
          colors: [Colors.transparent, Colors.black],
          // ... from the top (transparent) to half (0.5) of the way to the bottom.
          stops: [0.0, 0.5],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
