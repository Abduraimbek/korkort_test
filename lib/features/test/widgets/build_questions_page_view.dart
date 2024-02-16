import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/test_controller.dart';
import 'build_gif.dart';
import 'build_question_image.dart';
import 'build_question_text.dart';
import 'build_question_variant.dart';

class BuildQuestionsPageView extends HookConsumerWidget {
  const BuildQuestionsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    final questions =
        ref.watch(testControllerProvider.select((value) => value.questions));

    ref.listen(
      testControllerProvider.select((value) => value.currentIndex),
      (previous, next) {
        pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );

    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final item = questions[index];

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              if (item.gif != null) BuildGif(question: item),
              if (item.gif == null && item.image != null)
                BuildQuestionImage(question: item),
              BuildQuestionText(question: item),
              for (var i = 0; i < item.variants.length; i++)
                BuildQuestionVariant(
                  variant: item.variants[i],
                  isColored: item.answer == i,
                  variantIndex: i,
                  answered: item.answer != null,
                ),
            ],
          ),
        );
      },
    );
  }
}
