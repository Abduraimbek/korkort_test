import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../controller/test_controller.dart';

class BuildProgress extends ConsumerStatefulWidget {
  const BuildProgress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BuildProgressState();
}

class _BuildProgressState extends ConsumerState<BuildProgress> {
  @override
  Widget build(BuildContext context) {
    final questions =
        ref.watch(testControllerProvider.select((value) => value.questions));

    final width = MediaQuery.sizeOf(context).width - 48 - 50;

    double all = questions.length.toDouble();
    double answered =
        questions.where((e) => e.answer != null).length.toDouble();

    return Row(
      children: [
        Container(
          width: width,
          height: 6,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0CF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            height: 6,
            width: (answered * width) / all,
            decoration: BoxDecoration(
              color: kkColorPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${answered.toInt()}/${all.toInt()}',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: const Color(0xFF262626).withOpacity(.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
