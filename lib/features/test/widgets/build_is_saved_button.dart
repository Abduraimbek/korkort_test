import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:korkort_test/common/widgets/custom_app_bar_button.dart';

import '../controller/test_controller.dart';

class BuildIsSavedButton extends ConsumerWidget {
  const BuildIsSavedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(testControllerProvider);
    final isSaved = state.questions[state.currentIndex].isSaved;

    return CustomAppBarButton(
      onPressed: () {},
      icon: isSaved ? Icons.bookmark : Icons.bookmark_outline,
    );
  }
}
