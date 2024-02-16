import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/test_controller.dart';
import '../model/question.dart';

class BuildQuestionVariant extends ConsumerWidget {
  const BuildQuestionVariant({
    super.key,
    required this.variant,
    required this.isColored,
    required this.variantIndex,
    required this.answered,
  });

  final QuestionVariant variant;
  final bool isColored;
  final int variantIndex;
  final bool answered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGreen = variant.isCorrect && isColored;
    final isRed = !variant.isCorrect && isColored;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: const Color(0xFF333333).withOpacity(0.05),
        child: ListTile(
          onTap: () {
            if (!answered) {
              ref.read(testControllerProvider.notifier).answer(variantIndex);
            }
          },
          title: Text(
            variant.text,
            style: TextStyle(
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 17.07 / 14,
            ),
          ),
          leading: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isGreen
                  ? const Color(0xFF94D073)
                  : isRed
                      ? const Color(0xFFFF6967)
                      : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: isGreen
                    ? const Color(0xFF94D073)
                    : isRed
                        ? const Color(0xFFFF6967)
                        : const Color(0xFFD4D4D4),
              ),
            ),
            child: isGreen
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : isRed
                    ? const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      )
                    : null,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: isGreen
              ? const Color(0xFFEAF0CF)
              : isRed
                  ? const Color(0xFFF6E5E5)
                  : Colors.white,
        ),
      ),
    );
  }
}
