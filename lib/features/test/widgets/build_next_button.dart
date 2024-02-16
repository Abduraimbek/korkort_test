import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../controller/test_controller.dart';

class BuildNextButton extends ConsumerWidget {
  const BuildNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(testControllerProvider);
    final isAnswered = state.questions[state.currentIndex].answer != null;
    final isLast = state.questions.length - 1 == state.currentIndex;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 70),
      child: isAnswered
          ? ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size.fromHeight(50),
                  ),
                  maximumSize: const MaterialStatePropertyAll(
                    Size.fromHeight(50),
                  ),
                  minimumSize: const MaterialStatePropertyAll(
                    Size.fromHeight(50),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    kkColorPrimary,
                  ),
                  foregroundColor: const MaterialStatePropertyAll(
                    Color(0xFFFFFFFF),
                  ),
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 26 / 16,
                    ),
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (isLast) {
                    Navigator.of(context).pop();
                  } else {
                    ref.read(testControllerProvider.notifier).nextQuestion();
                  }
                },
                child: Text(isLast ? 'Finish' : 'Nästa fråga'),
              ),
            )
          : ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size.fromHeight(50),
                  ),
                  maximumSize: const MaterialStatePropertyAll(
                    Size.fromHeight(50),
                  ),
                  minimumSize: const MaterialStatePropertyAll(
                    Size.fromHeight(50),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color(0xFFEAECF0),
                  ),
                  foregroundColor: const MaterialStatePropertyAll(
                    Color(0xFF838FA0),
                  ),
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 26 / 16,
                    ),
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: null,
                child: Text(isLast ? 'Finish' : 'Nästa fråga'),
              ),
            ),
    );
  }
}
