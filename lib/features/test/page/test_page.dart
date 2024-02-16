import 'package:flutter/material.dart';
import 'package:korkort_test/common/theme/colors.dart';

import '../widgets/build_finish_test_button.dart';
import '../widgets/build_is_saved_button.dart';
import '../widgets/build_next_button.dart';
import '../widgets/build_progress.dart';
import '../widgets/build_questions_page_view.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kkColorAppBarBackground,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: BuildFinishTestButton(),
        ),
        title: const Text('Träningsprov'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: BuildIsSavedButton(),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(34),
          child: Padding(
            padding: EdgeInsets.only(bottom: 1, left: 24, right: 24),
            child: BuildProgress(),
          ),
        ),
      ),
      body: const Column(
        children: [
          Expanded(
            child: BuildQuestionsPageView(),
          ),
          BuildNextButton(),
        ],
      ),
    );
  }
}
