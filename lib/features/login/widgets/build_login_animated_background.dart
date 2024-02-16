import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/theme/colors.dart';

class BuildLoginAnimatedBackground extends HookConsumerWidget {
  const BuildLoginAnimatedBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: kkColorAppBarBackground,
    );

    // final index = ref.watch(loginBackgroundAnimationControllerProvider);

    // return AnimatedContainer(
    //   duration: const Duration(milliseconds: 1000),
    //   width: double.infinity,
    //   height: double.infinity,
    //   decoration: BoxDecoration(
    //     color: Colors.red,
    //     gradient: RadialGradient(
    //       center: Alignment(
    //         <double>[-1, 0, 1][index],
    //         -.8,
    //       ),
    //       radius: 4,
    //       colors: <Color>[
    //         kkColorPrimary,
    //         kkColorAppBarBackground.withOpacity(.8),
    //       ],
    //       stops: const <double>[-.1, 0.2],
    //     ),
    //   ),
    // );
  }
}
